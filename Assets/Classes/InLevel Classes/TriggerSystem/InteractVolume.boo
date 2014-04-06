import UnityEngine

class InteractVolume (MonoBehaviour): 

	public interactTile as GameObject

	virtual public def Interact(interactee as GameObject):
		interactTile.GetComponent[of InteractableTile]().Interact()