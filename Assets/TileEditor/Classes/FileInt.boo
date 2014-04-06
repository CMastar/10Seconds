import UnityEngine
import System.IO
import System.Xml.Serialization

class FileInt (MonoBehaviour):
	public elementPosition as Vector2
	public editorTile as GameObject
	public saveLoadPath as string
	public fileExtention as string
	GUIMode as int = 0
	levelSize as (int)
	editorTiles as (GameObject, 2)
	tileModifier as TileModifier
	tileSelector as TileSelectInt
	levelName as string = "A Level"
	fileName as string = "alvel"
	levelDescription as string = "This is a level"
	objectiveTriggers as string = ""
	objectiveDescriptions as string = ""
	
	
	def Start ():
		levelSize = (20,3,20)
		tileModifier = gameObject.GetComponent[of TileModifier]()
		tileSelector = gameObject.GetComponent[of TileSelectInt]()
		
	def ClearEditorTiles(): // Clears out all the clickable editor tiles
		if editorTiles != null:
			for item in editorTiles:
				GameObject.Destroy(item)
	
	def SaveLevel(path as string, name as string, additionalParams as Hash):
		writer = StreamWriter(path)
		serializer = XmlSerializer(LevelSave)
		level = LevelSave()
		level.levelName = name
		for i in range(3): //convert (int) to vector3
			level.levelSize[i] = levelSize[i]
		level.SetAdditionalParameters(additionalParams)
		level.tiles = tileModifier.GetTileSaves()
		serializer.Serialize(writer, level)
		writer.Close()
		
	def LoadLevel(path as string):
		ClearEditorTiles()
		TriggerManager.Initalize()
		reader = StreamReader(path)
		serializer = XmlSerializer(LevelSave)
		level as LevelSave = serializer.Deserialize(reader)
		levelName = level.levelName
		levelParams = level.GetAdditionalParameters()
		levelDescription = levelParams["Description"]
		unless levelParams["ObjectiveTriggers"] == null:
			objectiveTriggers = levelParams["ObjectiveTriggers"]
		unless levelParams["ObjectiveDescriptions"] == null:
			objectiveDescriptions = levelParams["ObjectiveDescriptions"]
		levelSize = (level.levelSize[0] cast int,level.levelSize[1] cast int,level.levelSize[2] cast int)
		BuildLevel(levelSize)
		tileModifier.PlaceTiles(level.tiles)
		tileSelector.SetLevelHeight(level.levelSize[1] cast int)
		
	
	def BuildLevel(size as (int)):
		editorTiles = matrix(GameObject,size[0],size[2])
		for x in range (size[0]):
			for z in range(size[2]):
				editorTiles[x,z] = Instantiate(editorTile,Vector3(x, size[1] + 1, z),Quaternion.identity)
		tileModifier.OnNewLevel(size[0],size[1],size[2])
	
	def NewLevelWindow(windowID as int):
		//GUI.Box(Rect(0,0,300,200), "New Level")
		GUI.Label(Rect(10,50,40,40),"X")
		levelSize[0] = int.Parse(GUI.TextField(Rect(50,50,130,40),levelSize[0].ToString()))
		GUI.Label(Rect(10,100,40,40),"Y")
		levelSize[1] = int.Parse(GUI.TextField(Rect(50,100,130,40),levelSize[1].ToString()))
		GUI.Label(Rect(10,150,40,40),"Z")
		levelSize[2] = int.Parse(GUI.TextField(Rect(50,150,130,40),levelSize[2].ToString()))
		if GUI.Button(Rect(10,200,85,40),"Create"):
			ClearEditorTiles()
			BuildLevel(levelSize)
			tileSelector.SetLevelHeight(levelSize[1])
			GUIMode = 0
			TriggerManager.Initalize()
		if GUI.Button(Rect(105,200,85,40),"Cancel"):
			GUIMode = 0
	
	def SaveWindow(windowID as int):
		GUI.Label(Rect(10,10,100,30),"Filename")
		GUI.Label(Rect(10,50,100,30),"Level Name")
		GUI.Label(Rect(10,90,100,30),"Description")
		fileName = GUI.TextField(Rect(120,10,100,30),fileName)
		levelName = GUI.TextField(Rect(120,50,100,30),levelName)
		levelDescription = GUI.TextField(Rect(120,90,100,30),levelDescription)
		objectiveTriggers = GUI.TextArea(Rect(230,50,100,200),objectiveTriggers)
		objectiveDescriptions = GUI.TextArea(Rect(340,50,100,200),objectiveDescriptions)
		if GUI.Button(Rect(10,130,100,30),"Save"):
			GUIMode = 0
			SaveLevel("$saveLoadPath$fileName.$fileExtention",levelName,{"Description" : levelDescription, "ObjectiveTriggers" : objectiveTriggers, "ObjectiveDescriptions" : objectiveDescriptions})
		if GUI.Button(Rect(110,130,100,30),"Cancel"):
			GUIMode = 0
		if GUI.Button(Rect(10,170,200,30),"Save and Test"):
			GUIMode = 0
			SaveLevel("$saveLoadPath$fileName.$fileExtention",levelName,{"Description" : levelDescription, "ObjectiveTriggers" : objectiveTriggers, "ObjectiveDescriptions" : objectiveDescriptions})
			Globals.loadFromGlobal = true
			Globals.levelPath = "$saveLoadPath$fileName.$fileExtention"
			Application.LoadLevel("levelview")
	
	def LoadWindow(windowID as int):
		GUI.Label(Rect(10,40,100,30),"File name")
		fileName = GUI.TextField(Rect(120,40,100,30),fileName)
		if GUI.Button(Rect(10,80,100,30),"Load"):
			LoadLevel("$saveLoadPath$fileName.$fileExtention")
			GUIMode = 0
		if GUI.Button(Rect(120,80,100,30),"Cancel"):
			GUIMode = 0
		

	def OnGUI():
		GUI.BeginGroup(Rect(elementPosition.x,elementPosition.y,200,100)) // New level, save level, load level
		//New Level
		if GUI.Button(Rect(0,0,200,40),"New level"):
			GUIMode = 1
			
		//Save level
		if GUI.Button(Rect(0,50,95,40),"Save level"):
			GUIMode = 2
		
		//Load level
		if GUI.Button(Rect(105,50,95,40),"Load level"):
			GUIMode = 3
		GUI.EndGroup()	
		
		if GUIMode == 1:
			GUI.Window(0,Rect(Screen.width / 2 - 100, Screen.height / 2 - 150, 200, 300), NewLevelWindow, "Level Parameters")
		if GUIMode == 2:
			GUI.Window(1,Rect(Screen.width / 2 - 220, Screen.height / 2 - 225, 450, 250), SaveWindow, "Save Level")
		if GUIMode == 3:
			GUI.Window(2,Rect(Screen.width / 2 - 110, Screen.height / 2 - 150, 220, 150), LoadWindow, "Load Level")