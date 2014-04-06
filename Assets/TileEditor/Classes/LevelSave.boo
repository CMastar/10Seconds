import UnityEngine

class LevelSave: 

	public levelName as string
	public levelSize as Vector3
	public tiles as List[of TileSave]
	public additionalParametersKeys as (object)
	public additionalParametersValues as (object)

	public def SetAdditionalParameters(data as Hash):
		additionalParametersKeys = array(data.Keys)
		additionalParametersValues = array(data.Values)
		
	public def GetAdditionalParameters():
		params = Hash()
		for i in range(len(additionalParametersKeys)):
			params[additionalParametersKeys[i]] = additionalParametersValues[i]
		return params