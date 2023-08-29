from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import numpy as np
import tensorflow as tf
from utils import read_and_resize
import joblib

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

IMG_SIZE = (256, 256)
IMG_SHAPE = IMG_SIZE + (3,)

base_model = tf.keras.applications.VGG16(input_shape=IMG_SHAPE,
                                               include_top=False,
                                               weights='imagenet')

MODEL = joblib.load('models/svm_model.pkl')

CLASS_NAMES = [
    'Early_blight',
    'Late_blight',
    'Healthy'
]

@app.post("/api/predict")
async def predict(file: UploadFile = File(...)):
    image = read_and_resize(await file.read())
    img_batch = np.expand_dims(image, 0)

    features = base_model.predict(img_batch)
    features = features.reshape(features.shape[0], -1)

    predictions = MODEL.predict(features)
    predicted_class = CLASS_NAMES[predictions[0]]
    
    return {
        'class': predicted_class
    }


if __name__ == "__main__":
    uvicorn.run(app, host='localhost', port=8000)