import UnityEngine

class BreakableTile (TriggerableTile): 
	
	triggerOnly = false
	public afterBreakMaterial as Material
	initalMaterial as Material
	
	def Start():
		initalMaterial = renderer.material
	
	public def Smash():
		unless triggerOnly:
			ActualBreak()
			unless triggeredObject == null:
				triggeredObject.GetComponent[of Triggerable]().Trigger()
			
		
	def ActualBreak():
		unless particleSystem == null:
			particleSystem.Play()
		if afterBreakMaterial == null:
			collider.enabled = false
			renderer.enabled = false
		else:
			collider.enabled = false
			renderer.material = afterBreakMaterial

	public def Trigger():
		ActualBreak()
		unless triggeredObject == null:
			triggeredObject.GetComponent[of Triggerable]().Trigger()
		
	public override def Reset():
		//print("Breakable reset")
		collider.enabled = true
		renderer.enabled = true
		unless initalMaterial == null: // Sometimes reset has apparently run before start
			renderer.material = initalMaterial
		unless triggeredObject == null:
			triggeredObject.GetComponent[of Triggerable]().Reset()