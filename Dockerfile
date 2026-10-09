
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, HttpUrl
import shutil

app = FastAPI(
    title="ClipFarm AI BRAIN",
    version="5.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

class VideoRequest(BaseModel):
    video_url: HttpUrl

@app.get("/")
def home():
    return {
        "status": "ok",
        "service": "ClipFarm AI Video Engine",
        "version": "5.0.0"
    }

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/capabilities")
def capabilities():
    return {
        "ffmpeg": shutil.which("ffmpeg") is not None,
        "highlight_detection": False,
        "mp4_rendering": False
    }

@app.post("/analyze")
def analyze(request: VideoRequest):
    url = str(request.video_url)
    if not any(host in url for host in [
        "youtube.com/",
        "youtu.be/"
    ]):
        raise HTTPException(
            status_code=400,
            detail="Invalid YouTube URL"
        )

    return {
        "status": "received",
        "video_url": url,
        "message": "Video processing pipeline not yet implemented."
    }
    
