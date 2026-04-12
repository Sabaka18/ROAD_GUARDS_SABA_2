"""
Feature 4 — Report Prioritization Scoring
==========================================
Pure Python, no ML library needed.

Score formula (0–100):
  priority = severity_score
           + category_score
           + location_score
           + time_escalation_score

Each component is weighted so the total stays within 0–100.
"""

from datetime import datetime, timezone


# ── 1. SEVERITY WEIGHTS ──────────────────────────────────────────────────────
# Adjust these values to match your severity labels in the DB
SEVERITY_SCORES = {
    "severe":   45,
    "moderate": 25,
    "mild":     10,
    None:       10,   # fallback if severity not yet assessed
}


# ── 2. DAMAGE CATEGORY WEIGHTS ───────────────────────────────────────────────
# Higher = more dangerous / urgent
# Keys must match your category_id values in the DB
# ⚠️  REPLACE the numbers with your actual category_id values once you see schema
CATEGORY_SCORES = {
    1:  25,   # Pothole          — high risk to vehicles
    2:  20,   # Traffic light    — high risk at intersections
    3:  15,   # Road drain       — flood risk
    4:  10,   # Manhole cover    — injury risk
    5:  10,   # Speed bump       — vehicle damage
    6:  10,   # Road sign        — navigation hazard
    7:  10,   # Street light     — night safety
    8:   5,   # Abandoned vehicle
    9:   5,   # Vehicle obstruction
    10: 15,   # Road barrier     — safety critical
    11: 15,   # Rockfall net     — safety critical
}
DEFAULT_CATEGORY_SCORE = 10


# ── 3. LOCATION TYPE WEIGHTS ─────────────────────────────────────────────────
# Based on location string keywords — no extra data source needed
LOCATION_KEYWORDS = [
    (["school", "مدرسة"],               20),  # school zones — highest priority
    (["hospital", "مستشفى"],            20),  # hospitals
    (["intersection", "تقاطع"],         18),  # intersections
    (["highway", "طريق سريع", "freeway"], 16), # highways
    (["main", "رئيسي", "central"],      12),  # main roads
    (["residential", "سكني"],            8),  # residential
]
DEFAULT_LOCATION_SCORE = 8


# ── 4. TIME ESCALATION ───────────────────────────────────────────────────────
# Score increases the longer a report stays unresolved
TIME_ESCALATION = [
    (30,  10),   # older than 30 days  → +10
    (14,   7),   # older than 14 days  → +7
    (7,    4),   # older than 7 days   → +4
    (3,    2),   # older than 3 days   → +2
    (0,    0),   # less than 3 days    → +0
]


# ─────────────────────────────────────────────────────────────────────────────

def _severity_score(severity: str | None) -> int:
    if severity:
        severity = severity.lower().strip()
    return SEVERITY_SCORES.get(severity, SEVERITY_SCORES[None])


def _category_score(category_id: int | None) -> int:
    return CATEGORY_SCORES.get(category_id, DEFAULT_CATEGORY_SCORE)


def _location_score(location: str | None) -> int:
    if not location:
        return DEFAULT_LOCATION_SCORE
    location_lower = location.lower()
    for keywords, score in LOCATION_KEYWORDS:
        if any(kw.lower() in location_lower for kw in keywords):
            return score
    return DEFAULT_LOCATION_SCORE


def _time_score(created_at: datetime | None) -> int:
    if not created_at:
        return 0
    now = datetime.now(timezone.utc)
    # Make created_at timezone-aware if it isn't already
    if created_at.tzinfo is None:
        created_at = created_at.replace(tzinfo=timezone.utc)
    days_old = (now - created_at).days
    for threshold_days, score in TIME_ESCALATION:
        if days_old >= threshold_days:
            return score
    return 0


def calculate_priority_score(report: dict) -> dict:
    """
    Takes a report dict and returns a priority score with breakdown.

    Expected keys in report dict:
    ─────────────────────────────────────────────────────────────
    ⚠️  COLUMN NAME MAPPING — update these once you see your schema
    ─────────────────────────────────────────────────────────────
    report["id"]           → primary key
    report["category_id"]  → damage category (int)
    report["severity"]     → 'mild' / 'moderate' / 'severe' (str or None)
    report["location"]     → place name string (str or None)
    report["created_at"]   → datetime object
    report["latitude"]     → float (reserved for future use)
    report["longitude"]    → float (reserved for future use)
    """

    s_score   = _severity_score(report.get("severity"))
    c_score   = _category_score(report.get("category_id"))
    l_score   = _location_score(report.get("location"))
    t_score   = _time_score(report.get("created_at"))

    total = min(s_score + c_score + l_score + t_score, 100)

    return {
        "report_id":        report.get("id"),
        "priority_score":   total,
        "breakdown": {
            "severity_score":   s_score,
            "category_score":   c_score,
            "location_score":   l_score,
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
