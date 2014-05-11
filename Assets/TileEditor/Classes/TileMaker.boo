import UnityEngine
import System
import System.IO
import System.Xml.Serialization


static class TileMaker : 

	public def PlaceTile(tileType as GameObject, position as Vector3, rotation as Quaternion, *additionalParameters as (Hash)):
		tile as GameObject = GameObject.Instantiate(tileType, position, rotation) //Create a tile in the selected position
		tile.name = tile.name[0:-7] // drop the "(clone)" tag
		if additionalParameters != null:
			tileScript = tile.GetComponent[of BaseTile]()	
			for item in additionalParameters:
				tileScript.SetParameters(item)
		return tile

	public def PlaceLevel(reader as TextReader) as (GameObject,3):
		serializer = XmlSerializer(LevelSave)
		levelData as LevelSave = serializer.Deserialize(reader)
		allTiles = matrix(GameObject,levelData.levelSize.x, levelData.levelSize.y, levelData.levelSize.z)
		for item as TileSave in levelData.tiles:
			tileToPlace = UnityEngine.Resources.Load(item.tileType)
			if tileToPlace == null:
				print("Tile " + item.tileType + " not found")
			else:
				allTiles[item.position.x, item.position.y, item.position.z] = PlaceTile(UnityEngine.Resources.Load(item.tileType), item.position, item.rotation, item.GetAdditionalParameters())
		return allTiles
		
	public def PlaceLevel(levelData as LevelSave):
		allTiles = matrix(GameObject,levelData.levelSize.x, levelData.levelSize.y, levelData.levelSize.z)
		for item as TileSave in levelData.tiles:
			tileToPlace = UnityEngine.Resources.Load(item.tileType)
			if tileToPlace == null:
				print("Tile " + item.tileType + " not found")
			else:
				allTiles[item.position.x, item.position.y, item.position.z] = PlaceTile(UnityEngine.Resources.Load(item.tileType), item.position, item.rotation, item.GetAdditionalParameters())
		return allTiles
		
	public def ResetLevel(levelData as LevelSave, tiles as (GameObject,3)) as (GameObject,3):
		for item as TileSave in levelData.tiles:
			tile = tiles[item.position.x, item.position.y, item.position.z].GetComponent[of BaseTile]()
			unless item.GetAdditionalParameters() == null:
				tile.SetParameters(item.GetAdditionalParameters())
			tile.Reset()
		return tiles