from fastapi import FastAPI, UploadFile
import subprocess

app = FastAPI()

@app.get("/version")
def get_version():
    result = subprocess.run(["prusa-slicer", "--version"], capture_output=True, text=True)
    return {"version": result.stdout.strip()}

@app.post("/slice")
async def slice_model(file: UploadFile):
    input_path = f"/tmp/{file.filename}"
    output_path = input_path.replace(".stl", ".gcode")
    with open(input_path, "wb") as f:
        f.write(await file.read())
    subprocess.run([
        "prusa-slicer",
        "--load", "/configs/mi_preset.ini",
        "--output", output_path,
        input_path
    ])
    with open(output_path, "r") as f:
        gcode = f.read()
    return {"gcode": gcode}