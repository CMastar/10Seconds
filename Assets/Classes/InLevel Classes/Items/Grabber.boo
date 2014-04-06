import UnityEngine

class Grabber (GameItem):
	
	
	def OnTriggerEnter(collided as Collider):
		print("Grabber collided with " + collided.name)
		unless collided.gameObject.GetComponent[of ItemInteractVolume]() == null:
			print("Grabber grabbing " + collided.name)
			collided.transform.parent.parent = transform
			collided.transform.parent.position = transform.position
			collided.transform.parent.GetComponent[of GameItem]().PickedUp()


