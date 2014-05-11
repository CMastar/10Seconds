import UnityEngine

class Door (Triggerable):
	
	public timeToMove as single
	startMoveTime as single
	moving = false
	targetRot as Quaternion
	oldRot as Quaternion
	
	def Start():
		Reset()

	def Trigger():
		//print("Door receive open request")
		unless moving:
			//print("Door opening")
			startMoveTime = Time.time
			temp = targetRot
			targetRot = oldRot
			oldRot = temp
	
	public virtual def Reset():
		startMoveTime = Time.time + timeToMove
		targetRot = Quaternion.identity
		oldRot = Quaternion.Euler(0,-90,0)
		
	def Update():
		if transform.localRotation == targetRot:
			moving = false
		else:
			moving = true
			transform.localRotation = Quaternion.Slerp(oldRot,targetRot,(Time.time - startMoveTime)/timeToMove)
