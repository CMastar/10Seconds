import UnityEngine
import System.IO

class LevelLoader (MonoBehaviour):
	public levelPath as string
	public levelExtention as string
	public MenuWidth as int
	public UseMenu as bool
	
	fileList as (FileInfo)
	fileNameList as (string)
	GUIClose = false
	selectedLevel as int
	levelTiles as (GameObject,3)
	levelData as LevelSave

	def Start ():
		if Globals.loadFromTextAsset:
			GUIClose = true
			LoadLevel(Globals.levelData)
			Globals.loadFromTextAsset = false
		elif Globals.loadFromGlobal:
			GUIClose = true
			LoadLevel(Globals.levelPath)
			Globals.loadFromGlobal = false
		/*else:
			directoryInfo = DirectoryInfo(levelPath)
			fileList = directoryInfo.GetFiles("*$levelExtention")
			fileNameList = array(String, len(fileList))
			i = 0
			for item as FileInfo in fileList:
				fileNameList[i] = item.Name
				i = i + 1 */
	
	def Update ():
		pass
		
	def LoadLevel(path as string):
		TriggerManager.Initalize()
		serializer = XmlSerializer(LevelSave)
		reader = StreamReader(path)
		levelData = serializer.Deserialize(reader)
		reader.Close()
		MakeLevel()
		
	def LoadLevel(text as TextAsset):
		TriggerManager.Initalize()
		serializer = XmlSerializer(LevelSave)
		reader = StringReader(text.text)
		levelData = serializer.Deserialize(reader)
		reader.Close()
		MakeLevel()
	
		
	def MakeLevel():
		levelTiles = TileMaker.PlaceLevel(levelData)
		GameObject.FindGameObjectWithTag("MainCamera").transform.position.x = levelData.levelSize.x /2 - 4
		GameObject.FindGameObjectWithTag("MainCamera").transform.position.z = levelData.levelSize.z /2
		timeCon = gameObject.GetComponent[of TimeControl]()
		params = levelData.GetAdditionalParameters()
		timeCon.levelDescription = params["Description"]
		timeCon.levelDescription = levelData.GetAdditionalParameters()["Description"]
		timeCon.SetVictoryConditions(params["ObjectiveTriggers"],params["ObjectiveDescriptions"])
		timeCon.Begin()

	public def ResetTiles():
		levelTiles = TileMaker.ResetLevel(levelData, levelTiles)

	def OnGUI():
		if GUIClose == false:
			GUI.BeginGroup(Rect((Screen.width / 2)-(MenuWidth/2),Screen.height / 2 - 200, MenuWidth, 400))
			selectedLevel = GUI.SelectionGrid(Rect(0, 0, MenuWidth, 340), selectedLevel, fileNameList,1)
			if GUI.Button(Rect(0,360,(MenuWidth / 2) - 5, 40), "Play"):
				LoadLevel(fileList[selectedLevel].FullName)
				GUIClose = true
			if GUI.Button(Rect((MenuWidth / 2) + 5, 360, (MenuWidth / 2) - 5, 40), "Back"):
				pass
			GUI.EndGroup()
