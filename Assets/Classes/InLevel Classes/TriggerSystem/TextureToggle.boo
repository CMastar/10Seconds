import UnityEngine

class TextureToggle (Triggerable): 

	public altMaterial as Material
	startMaterial as Material
	isStartMaterial = true
	
	
	def Start():
		startMaterial = renderer.material
		
	public def  Trigger():
		if isStartMaterial:
			renderer.material = altMaterial
			isStartMaterial = false
		else:
			renderer.material = startMaterial
			isStartMaterial = true
	
	public def Reset():
		unless startMaterial == null:
			renderer.material = startMaterial
		isStartMaterial = true