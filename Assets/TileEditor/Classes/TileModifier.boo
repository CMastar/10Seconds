import UnityEngine
import System

class TileModifier (MonoBehaviour):
	modeScript as ModeSelectInt
	tileSelectScript as TileSelectInt
	fileScript as FileInt
	inspector as InspectorInt
	lastEditorTile as GameObject
	allLevelTiles as (GameObject,3)
	selectedTile as GameObject
	currentPos as Vector3 = Vector3(0,0,0)

	def Start ():
		modeScript = gameObject.GetComponent[of ModeSelectInt]()
		tileSelectScript = gameObject.GetComponent[of TileSelectInt]()
		fileScript = gameObject.GetComponent[of FileInt]()
		inspector = gameObject.GetComponent[of InspectorInt]()
	
	def Update ():
		pass
		
	def ClearLevelTiles():
		if allLevelTiles != null:
			for item in allLevelTiles:
				if item != null:
					gameObject.Destroy(item)
		
	public def OnNewLevel(newX as int, newY as int, newZ as int):
		ClearLevelTiles()
		allLevelTiles = matrix(GameObject, newX, newY, newZ)
		return allLevelTiles
		
	
	public def PlaceTiles(tiles as List[of TileSave]):
		for item in tiles:
			if allLevelTiles[item.position.x,item.position.y,item.position.z] == null:
				tileToPlace = UnityEngine.Resources.Load(item.tileType)
				if tileToPlace == null:
					print("Tile " + item.tileType + " not found")
				else:
					allLevelTiles[item.position.x,item.position.y,item.position.z] = TileMaker.PlaceTile(tileToPlace, item.position, item.rotation, item.GetAdditionalParameters())		

	def OnEditorTileClicked(editorTile as GameObject):
		if lastEditorTile != null:
			lastEditorTile.GetComponent[of EditorTile]().DeSelect()
		lastEditorTile = editorTile
		currentPos = Vector3(editorTile.transform.position.x, tileSelectScript.selectedHeight, editorTile.transform.position.z)
		if modeScript.GetSelectedMode() == 0: // if mode is place tile mode
			if allLevelTiles[currentPos.x,currentPos.y,currentPos.z] == null:
				allLevelTiles[currentPos.x,currentPos.y,currentPos.z] = TileMaker.PlaceTile(tileSelectScript.GetSelectedTile(),currentPos,tileSelectScript.GetSelectedAngle())
		selectedTile = 	allLevelTiles[currentPos.x,currentPos.y,currentPos.z]
		if modeScript.GetSelectedMode() == 1: // if mode is inspect tile mode
			if selectedTile != null:
				inspector.Inspect(selectedTile)
				
	public def GetTileSaves():
		tileList = List[of TileSave]()
		for item as GameObject in allLevelTiles:
			if item != null:
				tileSave = TileSave()
				tileSave.AddData(item.name, item.transform.position, item.transform.rotation, item.GetComponent[of BaseTile]().GetParameters())
				tileList.Add(tileSave)
		return tileList
		