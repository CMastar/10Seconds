import UnityEngine

class InteractableTile (BaseTile): 
	// A tile with which a character can interact.
	
	public triggeredObject as GameObject // A GameObject, part of the same prefab as the tile, that will carry out an action when this tile is interacted with
	
	nameToTrigger = "" as String // Another object in the level to be triggered when this tile is interacted with
	
	
	public virtual def Interact():
		unless triggeredObject == null:
			triggeredObject.GetComponent[of Triggerable]().Trigger()
		unless nameToTrigger == "":
			print("Sending trigger request for $nameToTrigger")
			TriggerManager.TriggerTarget(nameToTrigger)
			
	public virtual def GetParameters():
		params = GetInteractableParameters()
		return params
		
	public virtual def SetParameters(params as Hash):
		SetInteractableParameters(params)
		
	public virtual def Reset():
		unless triggeredObject == null:
			triggeredObject.GetComponent[of Triggerable]().Reset()
		
	def SetInteractableParameters(params as Hash):
		SetBaseParameters(params)
		nameToTrigger = params["nameToTrigger"]
		
	def GetInteractableParameters():
		params = GetBaseParameters()
		params["nameToTrigger"] = nameToTrigger
		return params
		
	
	
