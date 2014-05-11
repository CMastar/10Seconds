import UnityEngine

class BaseTile (MonoBehaviour): 

	public virtual def GetParameters():
		params = GetBaseParameters()
		return params
		
	public virtual def SetParameters(params as Hash):
		SetBaseParameters(params)

		
	def GetBaseParameters():
		params = Hash()
		params["Tile Type"] = gameObject.name 
		params["Position"] = transform.position
		params["Rotation"] = transform.rotation.eulerAngles
		return params
		
	def SetBaseParameters(params as Hash):
		transform.rotation.eulerAngles = params["Rotation"]
		
	public virtual def Reset():
		pass
		
