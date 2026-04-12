from fastapi import APIRouter, HTTPException
from app.database import get_connection
from app.services.prioritization_service import calculate_priority_score

router = APIRouter()


# ─────────────────────────────────────────────────────────────────────────────
# GET /ai/prioritize
# Scores ALL pending reports and returns them ranked highest → lowest
# ─────────────────────────────────────────────────────────────────────────────
@router.get("/prioritize")
def prioritize_all_reports():
    """
    Fetches all pending reports from MySQL, scores each one,
    writes the score back to the DB, and returns ranked list.
    """
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        # ⚠️  UPDATE the query below once you confirm your column names
        # Current assumed columns: id, category_id, severity, location,
        #                          created_at, latitude, longitude, status
        cursor.execute("""
            SELECT
                id,
                category_id,
                severity,
                location,
                created_at,
                latitude,
                longitude,
                status
            FROM reports
            WHERE status = 'pending'
            ORDER BY created_at DESC
        """)
        reports = cursor.fetchall()

        if not reports:
            return {"message": "No pending reports found", "data": []}

        # Score each report
        scored = [calculate_priority_score(r) for r in reports]

        # Write scores back to DB
        # ⚠️  UPDATE 'priority_score' if your column is named differently
        update_cursor = conn.cursor()
        for item in scored:
            update_cursor.execute("""
                UPDATE reports
                SET priority_score = %s, priority_label = %s
                WHERE id = %s
            """, (
                item["priority_score"],
                item["priority_label"],
                item["report_id"]
            ))
        conn.commit()
        update_cursor.close()
        cursor.close()

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
    Scores one specific report by ID.
    Call this from your Lambda right after a report is saved to DB.
    """
    conn = None
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)

        # ⚠️  UPDATE column names to match your schema
        cursor.execute("""
            SELECT id, category_id, severity, location,
                   created_at, latitude, longitude, status
            FROM reports
            WHERE id = %s
        """, (report_id,))

        report = cursor.fetchone()
        cursor.close()

        if not report:
            raise HTTPException(status_code=404, detail=f"Report {report_id} not found")

        result = calculate_priority_score(report)

        # Write back to DB
        update_cursor = conn.cursor()
        update_cursor.execute("""
            UPDATE reports
            SET priority_score = %s, priority_label = %s
            WHERE id = %s
        """, (result["priority_score"], result["priority_label"], report_id))
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
