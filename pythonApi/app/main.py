from fastapi import FastAPI, UploadFile
from rmn import RMN
import numpy as np
from PIL import Image
import io
import numpy

 
m = RMN() 
app = FastAPI() 
 
@app.post("/upload/")
async def create_upload_file(uploadedFile: UploadFile):
 
    '''
    This function make predicitons and return information about one person emotion
    '''
 
    if uploadedFile.content_type != "image/jpeg":
        return {"status": False, "comment": f"image/jpeg expected {uploadedFile.content_type} given"}
 
    content = await uploadedFile.read()
    image = Image.open(io.BytesIO(content))
    image_array = np.array(image)
    return detectEmotion(image_array)
 
# @app.post("/upload-json/")
# async def upload_file_json(file: UploadFile = File(...)):
#     '''
#     This function make predictions and use json for responses
#     '''
#     return JSONResponse(status_code=200, content={"filename": file.filename})
 
 
def detectEmotion(image_array: numpy.ndarray):
    foundFace = True
    personWithMax = 0
    maxEmotionProba = 0
    m = RMN() 
    results = m.detect_emotion_for_single_frame(image_array)
    if 0 == len(results):
        return {"status": True, "face": False, "comment": "Don't contain any face"}
    else:
        for id, person in enumerate(results):
            if person['emo_proba'] > maxEmotionProba:
                maxEmotionProba = person['emo_proba']
                personWithMax = id
 
    person = results[personWithMax]
 
    return {"status": True, "face": True, "emotion": person['emo_label'], "proba": f"{maxEmotionProba:.2f}", 'xmin': person['xmin'], 'ymin': person['ymin'],'xmax': person['xmax'],'ymax': person['ymax']}
