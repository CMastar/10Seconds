import UnityEngine

class ItemMover (BaseTile): 
	
	destination as Vector3 = Vector3.zero

	public virtual def GetParameters():
		params = GetBaseParameters()
		params["Destination"] = destination
		return params
		
	public virtual def SetParameters(params as Hash):
		SetBaseParameters(params)
		destination = params["Destination"]
		
	def OnTriggerEnter(collided as Collider):
		item = collided.GetComponent[of ItemInteractVolume]()
		unless item == null:
			if collided.enabled:
				collided.transform.parent.position = destination
				print(gameObject.name + " has moved " + collided.transform.parent.name + " to " + destination.ToString())