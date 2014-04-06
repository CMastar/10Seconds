import UnityEngine

class character (Mover):
	
	public carryPosition as Transform
	moveHistory as List[of MoveStep]
	currentInteractVolumes as List[of InteractVolume]
	carriedItem as GameObject
	levelTimer as TimeControl

	def Start ():
		moveHistory = List[of MoveStep]()
		currentInteractVolumes = List[of InteractVolume]()
		levelTimer = GameObject.FindGameObjectWithTag("Control").GetComponent[of TimeControl]()
	

			
	def OnTriggerEnter(triggerVolume as Collider):
		interactVolume = triggerVolume.GetComponent[of InteractVolume]()
		unless interactVolume == null:
			currentInteractVolumes.Add(interactVolume)
		
	def OnTriggerExit(triggerVolume as Collider):
		interactVolume = triggerVolume.GetComponent[of InteractVolume]()
		unless interactVolume == null:
			currentInteractVolumes.Remove(interactVolume)
		
	def InteractWithCurrent():
		moveHistory.Insert(0,MoveStep(levelTimer.levelTime,"Interact"))
		if carriedItem == null:
			print(gameObject.name + " is interacting with stuffs")
			for item in currentInteractVolumes:
				item.Interact(gameObject)
		else:
			print(gameObject.name + " is dropping " + carriedItem.name)
			dropItem()
			
	def MovedForward(direction as Vector3):
		moveHistory.Insert(0,MoveStep(levelTimer.levelTime,"Move",direction))
			
	def PickUpItem(item as GameObject):
		if carriedItem == null:
			carriedItem = item
			carriedItem.transform.parent = transform
			carriedItem.transform.localPosition = carryPosition.localPosition
			carriedItem.transform.rotation = transform.rotation
			carriedItem.GetComponent[of GameItem]().PickedUp()
	
	def dropItem():
		carriedItem.transform.parent = null
		carriedItem.transform.position = transform.position
		carriedItem.GetComponent[of GameItem]().Dropped()
		currentInteractVolumes.Remove(carriedItem.GetComponent[of GameItem]().interactionVolume.GetComponent[of InteractVolume]())
		carriedItem = null
		
		
	def UseItem():
		moveHistory.Insert(0,MoveStep(levelTimer.levelTime,"UseItem"))
		unless carriedItem == null:
			carriedItem.GetComponent[of GameItem]().Use()
			
		
		
	public def MoveHistoryCopy() as List[of MoveStep]:
		copy = List[of MoveStep]()
		for item in moveHistory:
			copy.Add(item)
		return copy