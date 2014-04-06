import UnityEngine

class GameItem (MonoBehaviour): 
	heldBy as GameObject
	public interactionVolume as GameObject

	public def Dropped():
		interactionVolume.collider.enabled = true
		ChildDropped()
		
	virtual public def Use():
		pass
		
	public def PickedUp():
		heldBy = transform.parent.gameObject
		interactionVolume.collider.enabled = false
		unless particleSystem == null:
			particleSystem.Play()
		ChildPickedUp()

	virtual def ChildDropped():
		pass
		
	virtual def ChildPickedUp():
		pass