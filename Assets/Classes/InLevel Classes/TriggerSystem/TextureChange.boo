import UnityEngine

class TextureChange (Triggerable): 

	public altMaterial as Material
	startMaterial as Material
	
	
	def Start():
		startMaterial = renderer.material
		
	public def  Trigger():
		renderer.material = altMaterial

	
	public def Reset():
		unless startMaterial == null:
			renderer.material = startMaterial
