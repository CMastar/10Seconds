
class Replay (character): 

	runningHistory = false
	nextStep as MoveStep
	historyToRun as List[of MoveStep]
	

		
	def ChildUpdate ():
		if runningHistory:
			if levelTimer.levelTime > nextStep.time:
				if nextStep.action == "Move":
					MoveForward(nextStep.direction)
				else: 
					if nextStep.action == "Interact":
						InteractWithCurrent()
					elif nextStep.action == "UseItem":
							UseItem()
				if historyToRun.Count == 0:
					runningHistory = false
				else:
					nextStep = historyToRun.Pop()
		ReplayChildUpdate()
	
	virtual def ReplayChildUpdate():
		pass
	
	public def RunHistory(history as List[of MoveStep]):
		runningHistory = true
		disablePlayerControl()
		
		if history == null:
			runningHistory = false
			historyToRun = List[of MoveStep]()
		else:
			//print("History is " + history.Count + " long")
			if history.Count == 0:
				runningHistory = false
				historyToRun = List[of MoveStep]()
			else:
				historyToRun = history
				nextStep = historyToRun.Pop()

	virtual def disablePlayerControl():
		pass