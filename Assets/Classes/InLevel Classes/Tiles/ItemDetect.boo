import UnityEngine

class ItemDetect (BaseTile):
	
	itemDetected as string = ""
	targetTriggered as string = ""

	public virtual def GetParameters():
		params = GetBaseParameters()
		params["Item Detected"] = itemDetected
		params["Target Triggered"] = targetTriggered
		return params
		
	public virtual def SetParameters(params as Hash):
		SetBaseParameters(params)
		itemDetected = params["Item Detected"]
		targetTriggered = params["Target Triggered"]
		
	def OnTriggerEnter(collision as Collider):
		itemCheck = collision.gameObject.GetComponent[of ItemInteractVolume]()
		unless itemCheck == null:
			if collision.transform.parent.name[0:-7] == itemDetected:
				TriggerManager.TriggerTarget(targetTriggered)
