import UnityEngine

class TileSave: 

	public tileType as string
	public position as Vector3
	public rotation as Quaternion
	public additionalParametersKeys as (object)
	public additionalParametersValues as (object)
	
	public def AddData (type as string, pos as Vector3, rot as Quaternion, params as Hash):
		tileType = type
		position = pos
		rotation = rot
		additionalParametersKeys = array(params.Keys)
		additionalParametersValues = array(params.Values)

	public def GetAdditionalParameters():
		params = Hash()
		for i in range(len(additionalParametersKeys)):
			params[additionalParametersKeys[i]] = additionalParametersValues[i]
		return params