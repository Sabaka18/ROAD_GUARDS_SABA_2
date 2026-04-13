from fastapi import APIRouter, HTTPException
from app.database import get_connection
from app.services.prioritization_service import calculate_priority_score

router = APIRouter()


# ─────────────────────────────────────────────────────────────────────────────
# GET /ai/prioritize
# Scores ALL pending/under_review reports and returns them ranked highest → lowest
# ─────────────────────────────────────────────────────────────────────────────
@router.get("/prioritize")
def prioritize_all_reports():
    """
    Fetches all active (pending / under_review) reports joined with
    ai_assessments and road_segments, scores each one, writes the
    score back to ai_assessments.priority_score, and returns ranked list.
    """
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        # Join reports → ai_assessments (LEFT, score may not exist yet)
        #              → road_segments  (always exists via FK)
        cursor.execute("""
            SELECT
                r.report_id,
                r.category_id,
                r.subcategory_id,
                r.segment_id,
                r.status,
                r.submitted_at,
                r.latitude,
                r.longitude,
                r.governorate,
                a.assessment_id,
                a.severity_level,
                a.ai_damage_description,
                a.ai_solution_text,
                a.estimated_cost_min,
                a.estimated_cost_max,
                s.road_class,
                s.zone_context,
                s.avg_daily_traffic,
                s.avg_annual_precipitation_mm,
                s.nearest_landmark,
                s.segment_name
            FROM reports r
            LEFT JOIN ai_assessments a ON a.report_id = r.report_id
            JOIN road_segments s ON s.segment_id = r.segment_id
            WHERE r.status IN ('pending', 'under_review')
            ORDER BY r.submitted_at DESC
        """)
        reports = cursor.fetchall()
        cursor.close()

        if not reports:
            return {"message": "No active reports found", "data": []}

        # Score each report
        scored = [calculate_priority_score(r) for r in reports]

        # Write priority_score back to ai_assessments
        # If no assessment row exists yet, insert a placeholder row first
        update_cursor = conn.cursor()
        for item, report in zip(scored, reports):
            if report["assessment_id"] is not None:
                # Row exists — just update the priority_score
                update_cursor.execute("""
                    UPDATE ai_assessments
                    SET priority_score = %s
                    WHERE assessment_id = %s
                """, (item["priority_score"], report["assessment_id"]))
            else:
                # No AI assessment yet — insert a minimal row to record the score
                update_cursor.execute("""
                    INSERT INTO ai_assessments
                        (report_id, severity_level, priority_score, assessed_at)
                    VALUES (%s, 'mild', %s, NOW())
                    ON DUPLICATE KEY UPDATE priority_score = VALUES(priority_score)
                """, (report["report_id"], item["priority_score"]))
        conn.commit()
        update_cursor.close()

        # Sort by score descending
        scored.sort(key=lambda x: x["priority_score"], reverse=True)

        return {
            "total_reports_scored": len(scored),
            "data": scored
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        if conn and conn.is_connected():
            conn.close()


# ─────────────────────────────────────────────────────────────────────────────
# POST /ai/prioritize/single
# Score a single report — called right after a new report is submitted
# ─────────────────────────────────────────────────────────────────────────────
@router.post("/prioritize/single")
def prioritize_single_report(report_id: int):
    """
    Scores one specific report by report_id.
    Call this from your Flutter app right after a report is saved to the DB.
    """
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT
                r.report_id,
                r.category_id,
                r.subcategory_id,
                r.segment_id,
                r.status,
                r.submitted_at,
                r.latitude,
                r.longitude,
                r.governorate,
                a.assessment_id,
                a.severity_level,
                a.ai_damage_description,
                a.ai_solution_text,
                a.estimated_cost_min,
                a.estimated_cost_max,
                s.road_class,
                s.zone_context,
                s.avg_daily_traffic,
                s.avg_annual_precipitation_mm,
                s.nearest_landmark,
                s.segment_name
            FROM reports r
            LEFT JOIN ai_assessments a ON a.report_id = r.report_id
            JOIN road_segments s ON s.segment_id = r.segment_id
            WHERE r.report_id = %s
        """, (report_id,))

        report = cursor.fetchone()
        cursor.close()

        if not report:
            raise HTTPException(
                status_code=404,
                detail=f"Report {report_id} not found"
            )

        result = calculate_priority_score(report)

        # Write priority_score back to ai_assessments
        update_cursor = conn.cursor()
        if report["assessment_id"] is not None:
            update_cursor.execute("""
                UPDATE ai_assessments
                SET priority_score = %s
                WHERE assessment_id = %s
            """, (result["priority_score"], report["assessment_id"]))
        else:
            update_cursor.execute("""
                INSERT INTO ai_assessments
                    (report_id, severity_level, priority_score, assessed_at)
                VALUES (%s, 'mild', %s, NOW())
                ON DUPLICATE KEY UPDATE priority_score = VALUES(priority_score)
            """, (report["report_id"], result["priority_score"]))
        conn.commit()
        update_cursor.close()

        return result

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        if conn and conn.is_connected():
            conn.close()


# ─────────────────────────────────────────────────────────────────────────────
# GET /ai/prioritize/top
# Returns top N critical/high priority reports for the admin dashboard
# ─────────────────────────────────────────────────────────────────────────────
@router.get("/prioritize/top")
def get_top_priority_reports(limit: int = 20):
    """
    Returns the top N reports sorted by ai_assessments.priority_score DESC.
    Useful for the admin dashboard to surface the most urgent issues.
    """
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT
                r.report_id,
                r.category_id,
                r.subcategory_id,
                r.status,
                r.submitted_at,
                r.governorate,
                r.latitude,
                r.longitude,
                a.severity_level,
                a.priority_score,
                a.estimated_cost_min,
                a.estimated_cost_max,
                a.ai_solution_text,
                s.road_class,
                s.zone_context,
                s.segment_name,
                s.nearest_landmark,
                s.avg_daily_traffic
            FROM reports r
            JOIN ai_assessments a ON a.report_id = r.report_id
            JOIN road_segments s ON s.segment_id = r.segment_id
            WHERE r.status IN ('pending', 'under_review')
              AND a.priority_score IS NOT NULL
            ORDER BY a.priority_score DESC
            LIMIT %s
        """, (limit,))

        results = cursor.fetchall()
        cursor.close()

        return {
            "total": len(results),
            "data": results
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        if conn and conn.is_connected():
            conn.close()
