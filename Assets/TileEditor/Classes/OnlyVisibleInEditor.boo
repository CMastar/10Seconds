import UnityEngine

class OnlyVisibleInEditor (MonoBehaviour): 

	def Start ():
		if Application.loadedLevelName == "editer":
			renderer.enabled = true
	

