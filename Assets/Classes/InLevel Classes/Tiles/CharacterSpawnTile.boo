import UnityEngine

class CharacterSpawnTile (BaseTile): 
	
	public characterToSpawn as GameObject
	
	characterSpawned as GameObject
	playerControlled = false
	
	characterName as string = ""
	characterAge as string = ""
	characterLikes as string = ""
	isPlayerCharacter as bool = false
	PCOrder as long = 0
	spawnNextFrame = false
	savedHistory as List[of MoveStep]


	public def GetParameters() as Hash:
		params = GetBaseParameters()
		params["CharName"] = characterName
		params["Age"] = characterAge
		params["Likes"] = characterLikes
		params["PlayableCharacter"] = isPlayerCharacter
		return params
		
	public def SetParameters(params as Hash):
		SetBaseParameters(params)
		characterName = params["CharName"]
		characterAge = params["Age"]
		characterLikes = params["Likes"]
		isPlayerCharacter = params["PlayableCharacter"]

	public def SetPlayerControlled(setting as bool):
		playerControlled = setting
		
	def OnMouseUpAsButton():
		GameObject.FindGameObjectWithTag("Control").GetComponent[of TimeControl]().SetCurrentPC(self)
		
		
	def Update():
		if spawnNextFrame:
			ActualSpawn()
				
	def ActualSpawn():
		characterSpawned = Instantiate(characterToSpawn,transform.position,Quaternion.identity)
		if playerControlled:
			characterSpawned.GetComponent[of PlayerControlledCharacter]().EnablePlayerControl()
		else:
			characterSpawned.GetComponent[of Replay]().RunHistory(savedHistory)
		spawnNextFrame = false
				
	def SpawnCharacter(movementToPerform as List[of MoveStep]):
		savedHistory = movementToPerform
		spawnNextFrame = true
		

			
	public def Reset():
		unless characterSpawned == null:
			moveHistory = characterSpawned.GetComponent[of character]().MoveHistoryCopy()
			Object.Destroy(characterSpawned)
		SpawnCharacter(moveHistory)