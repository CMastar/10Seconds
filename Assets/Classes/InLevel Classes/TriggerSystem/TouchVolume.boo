import UnityEngine

class TouchVolume (MonoBehaviour):
	
	public interactTile as GameObject

	def OnTriggerEnter(collided as Collider):
		charTriggered = collided.GetComponent[of character]()
		unless charTriggered == null:
			interactTile.GetComponent[of InteractableTile]().Interact()
	
