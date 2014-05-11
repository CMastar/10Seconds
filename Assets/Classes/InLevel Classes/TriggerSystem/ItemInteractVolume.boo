import UnityEngine

class ItemInteractVolume (InteractVolume): 
	
	item as GameObject
	
	def Start():
		item = transform.parent.gameObject
	
	virtual public def Interact(interactee as GameObject):
		interactee.GetComponent[of character]().PickUpItem(item)
		
