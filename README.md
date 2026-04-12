# RoadGuard AI Server

FastAPI backend for all AI features in the RoadGuard app.
Runs separately from the AWS Lambda backend.

---

## Project structure

```
roadguard-ai/
├── app/
│   ├── main.py                         ← FastAPI app entry point
│   ├── database.py                     ← MySQL connection
│   ├── routers/
│   │   └── prioritization.py           ← Feature 4: priority scoring endpoints
│   └── services/
│       └── prioritization_service.py   ← Scoring logic (pure Python)
├── requirements.txt
├── render.yaml                         ← Render deployment config
├── .env.example                        ← Copy to .env locally
└── .gitignore
```

---

## Step 1 — Run locally

```bash
# 1. Clone / open the project folder
cd roadguard-ai

# 2. Create virtual environment
python -m venv venv
source venv/bin/activate        # Mac/Linux
venv\Scripts\activate           # Windows

# 3. Install dependencies
pip install -r requirements.txt

# 4. Create your .env file
cp .env.example .env
# Then open .env and fill in your MySQL credentials

# 5. Start the server
uvicorn app.main:app --reload
```

Server runs at: http://localhost:8000
API docs at:    http://localhost:8000/docs

---

## Step 2 — Test the endpoints

**Score all pending reports:**
```
GET http://localhost:8000/ai/prioritize
```

**Score a single report (by ID):**
```
POST http://localhost:8000/ai/prioritize/single?report_id=123
```

---

## Step 3 — Deploy to Render

1. Push this folder to a GitHub repo (can be private)
2. Go to https://render.com → New → Web Service
3. Connect your GitHub repo
4. Render auto-detects `render.yaml`
5. Go to Environment tab → add your DB credentials:
   - DB_HOST
   - DB_NAME
   - DB_USER
   - DB_PASSWORD
6. Click Deploy

Your server will be live at:
`https://roadguard-ai.onrender.com`

---

## Step 4 — Update column names

Open these two files and update column names to match your actual schema:

- `app/routers/prioritization.py`  → SQL SELECT queries (lines with `⚠️`)
- `app/services/prioritization_service.py` → report dict keys (lines with `⚠️`)

---

## Step 5 — Call from Flutter

After deploying, call from your Flutter app:

```dart
final response = await http.post(
  Uri.parse("https://roadguard-ai.onrender.com/ai/prioritize/single?report_id=$reportId"),
);
```

Call this right after a report is saved to your DB.

---

## Coming next (future features)

| File to add | Feature |
|---|---|
| `app/routers/photo_verification.py` | Feature 6 — CLIP photo verification |
| `app/routers/severity.py` | Feature 2 — YOLOv8 severity detection |
| `app/routers/duplicates.py` | Feature 1 — Duplicate report merging |
| `app/routers/solutions.py` | Feature 3 — Ollama cost + fix suggestions |
| `app/routers/depth.py` | Feature 7 — MiDaS pothole depth |
| `app/routers/prediction.py` | Feature 5 — Traffic + rain checkup prediction |
