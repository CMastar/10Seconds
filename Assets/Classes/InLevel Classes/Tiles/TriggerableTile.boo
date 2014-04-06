import UnityEngine

class TriggerableTile (BaseTile): 
	// A tile that can have some effected triggered from elsewhere in the level
	
	public triggerName as string = ""// The name by which this object responds
	public triggeredObject as GameObject // The game object on which the action will actually happen (as it is likley to be a door etc parented to this GameObject, rather than this GameObject itself
	


		
	virtual public def Trigger():
		unless triggeredObject == null:
			triggeredObject.GetComponent[of Triggerable]().Trigger()
		
		
	public virtual def GetParameters():
		params = GetTriggerableParameters()
		return params
		
	public virtual def SetParameters(params as Hash):
		SetTriggerParameters(params)
		
		
	def SetTriggerParameters(params as Hash):
		unless triggerName == null:
			TriggerManager.UnRegisterTarget(triggerName,self)
		SetBaseParameters(params)
		triggerName = params["triggerName"]
		unless triggerName == null or triggerName == "":
			TriggerManager.RegisterTarget(triggerName,self)
		
	def GetTriggerableParameters():
		params = GetBaseParameters()
		params["triggerName"] = triggerName
		return params
	
	public virtual def Reset():
		//print(gameObject.name + "reset as triggerable")
		unless triggeredObject == null:
			triggeredObject.GetComponent[of Triggerable]().Reset()