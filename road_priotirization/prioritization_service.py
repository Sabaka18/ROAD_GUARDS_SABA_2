"""
Feature 4 — Report Prioritization Scoring
==========================================
Pure Python, no ML library needed.

Score formula (0–100):
  priority = severity_score
           + category_score
           + zone_score
           + road_class_score
           + time_escalation_score

Each component is weighted so the total stays within 0–100.

DB Schema mapping:
  reports           → report_id, category_id, subcategory_id, segment_id,
                      status, submitted_at, latitude, longitude
  ai_assessments    → severity_level ('mild','moderate','severe','critical'),
                      priority_score
  road_segments     → road_class, zone_context, avg_daily_traffic,
                      avg_annual_precipitation_mm
"""

from datetime import datetime, timezone


# ── 1. SEVERITY WEIGHTS ──────────────────────────────────────────────────────
# Matches ai_assessments.severity_level ENUM('mild','moderate','severe','critical')
SEVERITY_SCORES = {
    "critical": 45,
    "severe":   35,
    "moderate": 20,
    "mild":     10,
    None:       10,   # fallback if AI assessment not yet run
}


# ── 2. DAMAGE CATEGORY WEIGHTS ───────────────────────────────────────────────
# Keys match problem_categories.category_id (AUTO_INCREMENT, max 12 rows in DB)
CATEGORY_SCORES = {
    1:  25,   # Pothole            — direct vehicle / tire damage
    2:  22,   # Traffic light      — intersection safety critical
    3:  15,   # Road drain         — flood / blockage risk
    4:  18,   # Manhole cover      — fall / injury risk
    5:  12,   # Speed bump         — vehicle damage
    6:  14,   # Road sign          — navigation & safety hazard
    7:  13,   # Road / street light — night-time visibility
    8:   8,   # Abandoned vehicle  — traffic obstruction
    9:   8,   # Vehicle obstruction — owner notification flow
    10: 20,   # Road metal barrier — high-speed safety critical
    11: 20,   # Rockfall net       — high-speed safety critical
    12: 10,   # Other / fallback
}
DEFAULT_CATEGORY_SCORE = 10


# ── 3. ZONE CONTEXT WEIGHTS ──────────────────────────────────────────────────
# Matches road_segments.zone_context
# ENUM('standard','school_zone','hospital_zone','commercial','roundabout','tunnel')
ZONE_SCORES = {
    "school_zone":   20,
    "hospital_zone": 20,
    "roundabout":    16,
    "tunnel":        15,
    "commercial":    10,
    "standard":       6,
}
DEFAULT_ZONE_SCORE = 6


# ── 4. ROAD CLASS WEIGHTS ────────────────────────────────────────────────────
# Matches road_segments.road_class
# ENUM('motorway','primary','secondary','urban','residential','unpaved')
ROAD_CLASS_SCORES = {
    "motorway":    15,
    "primary":     12,
    "secondary":    9,
    "urban":        7,
    "residential":  5,
    "unpaved":      4,
}
DEFAULT_ROAD_CLASS_SCORE = 5


# ── 5. TIME ESCALATION ───────────────────────────────────────────────────────
# Score increases the longer a report stays unresolved
# Based on reports.submitted_at
TIME_ESCALATION = [
    (30, 10),   # older than 30 days → +10
    (14,  7),   # older than 14 days → +7
    (7,   4),   # older than 7 days  → +4
    (3,   2),   # older than 3 days  → +2
    (0,   0),   # less than 3 days   → +0
]


# ─────────────────────────────────────────────────────────────────────────────

def _severity_score(severity_level: str | None) -> int:
    """Maps ai_assessments.severity_level to a score."""
    if severity_level:
        severity_level = severity_level.lower().strip()
    return SEVERITY_SCORES.get(severity_level, SEVERITY_SCORES[None])


def _category_score(category_id: int | None) -> int:
    """Maps reports.category_id to a score."""
    return CATEGORY_SCORES.get(category_id, DEFAULT_CATEGORY_SCORE)


def _zone_score(zone_context: str | None) -> int:
    """Maps road_segments.zone_context to a score."""
    if not zone_context:
        return DEFAULT_ZONE_SCORE
    return ZONE_SCORES.get(zone_context.lower().strip(), DEFAULT_ZONE_SCORE)


def _road_class_score(road_class: str | None) -> int:
    """Maps road_segments.road_class to a score."""
    if not road_class:
        return DEFAULT_ROAD_CLASS_SCORE
    return ROAD_CLASS_SCORES.get(road_class.lower().strip(), DEFAULT_ROAD_CLASS_SCORE)


def _time_score(submitted_at: datetime | None) -> int:
    """
    Time escalation based on reports.submitted_at.
    Score increases the longer a report stays unresolved.
    """
    if not submitted_at:
        return 0
    now = datetime.now(timezone.utc)
    if submitted_at.tzinfo is None:
        submitted_at = submitted_at.replace(tzinfo=timezone.utc)
    days_old = (now - submitted_at).days
    for threshold_days, score in TIME_ESCALATION:
        if days_old >= threshold_days:
            return score
    return 0


def calculate_priority_score(report: dict) -> dict:
    """
    Takes a report dict (joined with ai_assessments + road_segments)
    and returns a priority score with full breakdown.

    Expected keys — all map directly to DB column names:
    ────────────────────────────────────────────────────────────
    report["report_id"]      → reports.report_id          (int)
    report["category_id"]    → reports.category_id        (int)
    report["severity_level"] → ai_assessments.severity_level (str|None)
    report["zone_context"]   → road_segments.zone_context (str|None)
    report["road_class"]     → road_segments.road_class   (str|None)
    report["submitted_at"]   → reports.submitted_at       (datetime)
    report["latitude"]       → reports.latitude           (float, reserved)
    report["longitude"]      → reports.longitude          (float, reserved)
    ────────────────────────────────────────────────────────────
    """

    s_score = _severity_score(report.get("severity_level"))
    c_score = _category_score(report.get("category_id"))
    z_score = _zone_score(report.get("zone_context"))
    r_score = _road_class_score(report.get("road_class"))
    t_score = _time_score(report.get("submitted_at"))

    total = min(s_score + c_score + z_score + r_score + t_score, 100)

    return {
        "report_id":      report.get("report_id"),
        "priority_score": total,
        "breakdown": {
            "severity_score":   s_score,
            "category_score":   c_score,
            "zone_score":       z_score,
            "road_class_score": r_score,
            "time_score":       t_score,
        },
        "priority_label": _label(total),
    }


def _label(score: int) -> str:
    if score >= 70:
        return "critical"
    elif score >= 45:
        return "high"
    elif score >= 25:
        return "medium"
    else:
        return "low"
