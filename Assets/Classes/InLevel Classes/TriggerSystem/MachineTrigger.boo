

class MachineTrigger (Triggerable): 

	def Trigger():
		gameObject.GetComponent[of Machine]().Activate()
		
	def Reset():
		pass
