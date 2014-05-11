import UnityEngine

class PlayerControlledCharacter (Replay):
	
	playerControl = false
	
	def ChildStart():
		pass
		
	def ReplayChildUpdate():
		if playerControl and levelTimer.levelTime < levelTimer.timeLimit and levelTimer.levelTime > 0:
			if rigidbody.velocity.magnitude == 0:
				if Input.GetAxis('Vertical') != 0:
					MoveForward(Vector3.forward * Input.GetAxis('Vertical'))
				else:
					if Input.GetAxis('Horizontal') != 0:
						MoveForward(Vector3.right * Input.GetAxis('Horizontal'))
				if Input.GetButton("Fire2"):
					UseItem()
				
				if Input.GetButtonDown("Fire1"):
					InteractWithCurrent()
			
	public def EnablePlayerControl():
		unless runningHistory:
			playerControl = true
	
	public def DisablePlayerControl():
		playerControl = false