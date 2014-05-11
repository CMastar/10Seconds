import UnityEngine

class GenericItem (GameItem): 

	public itemType as string

	def Use():
		collided = Physics.RaycastAll(transform.position, transform.rotation * Vector3.forward,1)
		for item in collided:
			itemTarget as ItemTarget = item.collider.GetComponent[of ItemTarget]()
			unless itemTarget == null:
				itemTarget.ItemUsed(itemType)
