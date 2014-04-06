import UnityEngine

class ItemTarget (MonoBehaviour): 

	public interactableTile as GameObject
	public respondsToType as string
	
	def ItemUsed(itemType as string):
		if itemType == respondsToType:
			interactableTile.GetComponent[of InteractableTile]().Interact()
