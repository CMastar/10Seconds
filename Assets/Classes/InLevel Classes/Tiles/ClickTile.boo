

class ClickTile (InteractableTile): 

	def OnMouseUpAsButton():
		print(gameObject.name + " clicked")
		Interact()
