class TriggerWatcher (TriggerableTile): 

	public triggered = false
	public description = ""
	
	public def Reset():
		triggered = false
		
	public def Trigger():
		triggered = true
		print("Objective $description has been triggered")
