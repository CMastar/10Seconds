

static class TriggerManager (): 

	listOfTargets as Hash
	
	public def Initalize():
		listOfTargets = Hash()
	
	public def RegisterTarget(targetName as string ,targetScript as TriggerableTile):
		unless listOfTargets.ContainsKey(targetName):
			listOfTargets[targetName] = List[of TriggerableTile]()
		targets as List of TriggerableTile
		targets = listOfTargets[targetName]
		targets.Add(targetScript)
		
	public def UnRegisterTarget(targetName as string, targetScript as TriggerableTile):
		targets as List of TriggerableTile
		unless listOfTargets[targetName] == null:
			targets = listOfTargets[targetName]
			targets.Remove(targetScript)
		
	public def TriggerTarget(targetName as string):
		for target as TriggerableTile in listOfTargets[targetName]:
			target.Trigger()
 