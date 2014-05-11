import UnityEngine

class Machine (Mover):
	public Item as GameObject
	lastUsedItem as single = 0
	public useItemDelay as single = 1
	levelTimer as TimeControl
	activated as bool = false
	
	
	def Start():
		levelTimer = GameObject.FindGameObjectWithTag("Control").GetComponent[of TimeControl]()
		
		

	def ChildUpdate():
		if activated:
			if rigidbody.velocity.magnitude == 0:
				unless moveSpeed == 0:
					MoveForward(transform.rotation * Vector3.forward)
			if levelTimer.levelTime - lastUsedItem > useItemDelay:
				UseItem()
		
	def UseItem():
		unless Item == null:
			Item.GetComponent[of GameItem]().Use()
			lastUsedItem = levelTimer.levelTime
			
	def Activate():
		activated = true
