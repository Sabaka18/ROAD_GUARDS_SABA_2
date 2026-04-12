from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import prioritization

app = FastAPI(
    title="RoadGuard AI Server",
    description="AI backend for RoadGuard — damage detection, prioritization, and analysis",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(prioritization.router, prefix="/ai", tags=["Prioritization"])

@app.get("/")
def root():
    return {"status": "RoadGuard AI server is running"}

@app.get("/health")
def health():
    return {"status": "ok"}
