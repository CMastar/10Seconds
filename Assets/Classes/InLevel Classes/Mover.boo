import UnityEngine

abstract class Mover (MonoBehaviour):
	
	public gridSize as single = 1
	public moveSpeed as single
	previousPosition as Vector3

	def Update ():
		if rigidbody.velocity.magnitude > 0:
			if Math.Abs((transform.position - previousPosition).magnitude) > 1:
				rigidbody.velocity = Vector3.zero
				transform.position.x = Math.Round(transform.position.x)
				transform.position.z = Math.Round(transform.position.z)
		ChildUpdate()

	virtual def ChildUpdate():
		pass
		
	virtual def MovedForward(direciton as Vector3):
		pass
	
		
	def MoveForward(direction as Vector3):
		transform.LookAt(transform.position + direction,Vector3.up)
		MovedForward(direction)
		hitInfo as RaycastHit
		if rigidbody.SweepTest(transform.rotation * Vector3.forward,hitInfo,1):
			print(gameObject.name + " is blocked forward")
		else:
			previousPosition = transform.position
			rigidbody.velocity = transform.rotation * Vector3.forward * moveSpeed
			// print(gameObject.name + "moving from $previousPosition to " + (previousPosition + transform.rotation * Vector3.forward).ToString())
			