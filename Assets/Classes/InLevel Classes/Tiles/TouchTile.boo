import UnityEngine

class TouchTile (TriggerableTile):
	
	nameToTrigger = ""


	def OnTriggerEnter(collided as Collider):
		charTriggered = collided.GetComponent[of character]()
		unless charTriggered == null:
			unless nameToTrigger == "":
				print("Sending trigger request for $nameToTrigger")
				TriggerManager.TriggerTarget(nameToTrigger)
			
	public def GetParameters():
		params = GetTriggerableParameters()
		params["nameToTrigger"] = nameToTrigger
		return params
		
	public def SetParameters(params as Hash):
		SetTriggerParameters(params)
		nameToTrigger = params["nameToTrigger"]
		
		
	public def Trigger():
		collider.enabled = false
		unless triggeredObject == null:
			triggeredObject.GetComponent[of Triggerable]().Trigger()
		
		