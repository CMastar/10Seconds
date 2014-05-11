import UnityEngine

class TileSelectInt (MonoBehaviour):
	
	public elementPosition as Vector2
	public levelTiles as (GameObject) // The prefabs to be placable in the editor
	public levelTileNames as (string) // The names to be visible for said prefabs
	public listSize as int // Maximum number of tiles to display at once
	listPosition as int = 0
	selectedTileNumber as int = 0
	public selectedHeight as int = 0
	selectedAngleId as int = 0
	currentLevelHeight as int = 0

	def Start ():
		pass
		
	def Update():
		if Input.GetKeyUp(KeyCode.Q):
			if selectedHeight > 0:
				selectedHeight = selectedHeight - 1
		if Input.GetKeyUp(KeyCode.E):
			if selectedHeight < currentLevelHeight - 1:
				selectedHeight = selectedHeight + 1
	

	public def SetLevelHeight(height as int):
		currentLevelHeight = height
		selectedHeight = 0
		
	public def GetSelectedAngle():
		angle = Quaternion.identity
		angle.eulerAngles.y = selectedAngleId * 90
		return angle
		
	def OnGUI():
		GUI.BeginGroup(Rect(elementPosition.x,elementPosition.y,200,300)) // This group contains the elements for setting the tile to be placed
		
		//Make the list of tiles scroll if there are too many and draw the list of tiles
		if len(levelTileNames) > listSize:
			tileNames = levelTileNames[listPosition:(listPosition + listSize)]
			if GUI.Button(Rect(160, 100, 40, 40),"^"): // Scroll list up
				if listPosition > 0:
					listPosition = listPosition - 1
			if GUI.Button(Rect(160, 260, 40, 40),"v"): // scroll list down
				if listPosition < (len(levelTileNames) - listSize):
					listPosition = listPosition + 1
		else:
			tileNames = levelTileNames
		selectedTileNumber = GUI.SelectionGrid(Rect(0,100,150,200),selectedTileNumber,tileNames, 1)
		
		//Draw the height selector
		GUI.Box(Rect(50,50,100,40),"Height = $selectedHeight")
		if GUI.Button(Rect(0,50,40,40),"-"):
			if selectedHeight > 0:
				selectedHeight = selectedHeight - 1
		if GUI.Button(Rect(160,50,40,40),"+"):
			if selectedHeight < currentLevelHeight - 1:
				selectedHeight = selectedHeight + 1
				
		//Draw the direction selector
		selectedAngleId = GUI.SelectionGrid(Rect(0,0,200,40),selectedAngleId, ("V","<-","^","->"),4)
		GUI.EndGroup()
 
		
	public def GetSelectedTile():
		return levelTiles[selectedTileNumber + listPosition]