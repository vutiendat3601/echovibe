
@app.get("/tracks/{id}")
async def get_track(id: int):
  return {"id": id}
