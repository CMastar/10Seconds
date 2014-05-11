import UnityEngine

class BreakingTool (GameItem): 

	def Use():
		//Any animation also goes here.
		
		hit as RaycastHit
		if Physics.Raycast(transform.position, transform.rotation * Vector3.forward, hit, 1):
			print(gameObject.name + " hit " + hit.collider.name)
			breakable = hit.collider.GetComponent[of BreakableTile]()
			unless breakable == null:
				breakable.Smash()
	
