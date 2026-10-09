
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, HttpUrl
import os
import shutil

app = FastAPI(title="ClipFarm AI Video Engine", version="1.0.0")

class VideoRequest(BaseModel):
video_url: HttpUrl

@app.get("/")
def home():
return {
"status": "online",
"service": "ClipFarm AI Video Engine",
"version": "1.0.0"
}

@app.get("/health")
def health():
return {"status": "ok"}

@app.get("/capabilities")
def capabilities():
return {
"ffmpeg_available": shutil.which("ffmpeg") is not None,
"video_processing": "not_configured",
"note": "Processing pipeline still needs to be implemented."
}

@app.post("/analyze")
def analyze(request: VideoRequest):
url = str(request.video_url)

if not url.startswith(("https://www.youtube.com/",
                       "https://youtube.com/",
                       "https://youtu.be/")):
    raise HTTPException(
        status_code=400,
        detail="Please provide a valid YouTube URL."
    )

return {
    "status": "received",
    "video_url": url,
    "message": (
        "URL received. Highlight detection and MP4 rendering "
        "are not implemented yet."
    )
}
