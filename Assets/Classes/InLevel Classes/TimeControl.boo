import UnityEngine

class TimeControl (MonoBehaviour):
	
	public levelTime as single = 0
	startTime as single
	running = false
	public timeLimit as single
	waitingForStart = false
	//PCs as List[of GameObject]
	PCs as (GameObject)
	CurrentPC as CharacterSpawnTile
	begun = false
	PCPointer as long = 0
	OKed = false
	public levelDescription as string = ""
	triggerWatchers as List[of TriggerWatcher]
	public triggerWatcherPrefab as GameObject
	hasWon = false

	
	def Update ():
		pass
				
	def StartSession():
		startTime = Time.time
		running = true
		waitingForStart = false
		
	def FinishSession():
		running = false
		waitingForStart = false
		levelTime = 0
		CurrentPC.SetPlayerControlled(false)
		unless triggerWatchers == null:
			won = true
			for item in triggerWatchers:
				unless item.triggered:
					won = false
			if won:
				print("WEENER!")
				hasWon = true

		ResetLevel()
		PCVisibility(true)
		OKed = false

		
	def PCVisibility(state as bool):
		for item in PCs:
			item.renderer.enabled = state
			
			
	def OnGUI():
		w = Screen.width
		h = Screen.height
		if begun:
			if hasWon:
				GUI.Window(5,Rect( (w - 300) / 2,(h-100)/2,300,100),WinWindow,"")
			else:
				if running:
					levelTime = Time.time - startTime
					if levelTime > timeLimit:
						FinishSession()
				else:
					if waitingForStart:
						GUI.Window(2,Rect((w - 300) / 2, (h - 80) / 2, 300, 80),AwaitingStartWindow,"")
					else:
						unless OKed:
							GUI.Window(1,Rect( (w - 300) / 2,(h-100)/2,300,100),FinishedWindow,"")
						
				GUI.BeginGroup(Rect(10,10,200,500))
				GUI.Box(Rect(0,0,200,500),"")
				GUI.Label(Rect(10,10,180,40),"Time Elapsed: " + levelTime.ToString("00.0"))
				GUI.Label(Rect(10,50,180,90),levelDescription)
				unless CurrentPC == null: 
					params = CurrentPC.GetParameters()
					GUI.Label(Rect(10,150,180,90),params["CharName"] + Environment.NewLine + params["Age"] + " Years Old" + Environment.NewLine + "Likes " + params["Likes"])
				unless triggerWatchers == null:
					vertPos = 210
					for item in triggerWatchers:
						GUI.Label(Rect(10,vertPos,150,50),item.description)
						GUI.Label(Rect(160,vertPos,40,50),item.triggered.ToString())
						vertPos = vertPos + 60
				GUI.EndGroup()
		
	def FinishedWindow(windowID as int):
		GUI.Label(Rect(50,10,200,60),"10 Seconds are up" + Environment.NewLine + "Click on a character to control")
		if GUI.Button(Rect(10,50,135,40),"OK"):
			OKed = true
		/*
		if GUI.Button(Rect(10,50,135,40),"Retry This Character"):
			ResetLevel()
			waitingForStart = true
		if GUI.Button(Rect(155,50,135,40),"Next Character"):
			
			CurrentPC.SetPlayerControlled(false)
			NextPC()
			CurrentPC.SetPlayerControlled(true)
			ResetLevel()
			waitingForStart = true 
		*/
	
	def AwaitingStartWindow(windowId as int):
		GUI.Label(Rect(10,10,190,60),"Press any button to being your 10 seconds")
		if Input.anyKey:
			StartSession()
	
	def WinWindow(windowID as int):
		GUI.Label(Rect(100,10,100,50),"You Win")
		if GUI.Button(Rect(10,50,135,40),"Main Menu"):
			Application.LoadLevel("mainmenu")
		if GUI.Button(Rect(155,50,135,40),"Watch Replay"):
			hasWon = false
			StartSession()
			
	def GetPlayerCharacters():
		//PCs = List[of GameObject]()
		PCs = GameObject.FindGameObjectsWithTag("Character")
		/*PCList = List()
		for item as GameObject in charSpawns:
			details as Hash = item.GetComponent[of CharacterSpawnTile]().GetParameters()
			if details["PlayableCharacter"]:
				print("Adding " + details["CharName"] + " a " + item.GetType() + " as a Player Character at position " + details["PlayCharOrder"])
				PCs.Insert(details["PlayCharOrder"],item)
				PCList.Add(details["PlayCharOrder"])
		PCList.Sort()
		print(PCList) */
		
	public def Begin():

		GetPlayerCharacters()
		ResetLevel()
		begun = true
		PCVisibility(true)
		
	def ResetLevel():
		gameObject.GetComponent[of LevelLoader]().ResetTiles()
		unless triggerWatchers == null:
			for item in triggerWatchers:
				item.Reset()
		
	public def SetCurrentPC(PCToSet as CharacterSpawnTile):
		unless running:
			CurrentPC = PCToSet
			CurrentPC.SetPlayerControlled(true)
			CurrentPC.Reset()
			PCVisibility(false)
			waitingForStart = true
			
	public def SetVictoryConditions(trigs as string, descs as string):
		
		unless trigs == null or descs == null:
			triggerWatchers = List[of TriggerWatcher]()
			trigsArray = trigs.Split((Environment.NewLine,"\n"),StringSplitOptions.None)
			descsArray = descs.Split((Environment.NewLine,"\n"),StringSplitOptions.None)
			for I in range(trigsArray.Length):
				newWatch as GameObject = Instantiate(triggerWatcherPrefab,Vector3.zero,Quaternion.identity)
				trigWatch = newWatch.GetComponent[of TriggerWatcher]()
				params = trigWatch.GetParameters()
				params["triggerName"] = trigsArray[I]
				trigWatch.SetParameters(params)
				print("Watching trigger " + params["triggerName"])
				trigWatch.description = descsArray[I]
				triggerWatchers.Add(trigWatch)
		
			
		
