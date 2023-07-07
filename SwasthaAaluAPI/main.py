from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import numpy as np
import tensorflow as tf
from utils import read_and_resize
import os

app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:3000",
]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#MODEL = tf.keras.models.load_model(os.path.join("models", "content", "saved_model", "my_model"))
MODEL = tf.keras.models.load_model('models/my_model.h5', compile=False)


CLASS_NAMES = [
    'Early_blight',
    'Late_blight',
    'Healthy',
]


@app.post("/api/predict")
async def predict(file: UploadFile = File(...)):
    image = read_and_resize(await file.read())
    img_batch = np.expand_dims(image, 0)

    predictions = MODEL.predict(img_batch)
    predicted_class = CLASS_NAMES[np.argmax(predictions[0])]
    confidence = np.max(predictions[0])

    return {
        'class': predicted_class,
        'confidence': float(confidence)
    }


if __name__ == "__main__":
    uvicorn.run(app, host='localhost', port=8000)