import UnityEngine

class ModeSelectInt (MonoBehaviour):
	public elementPosition as Vector2
	selectedMode as int = 0
	

	def Start ():
		pass
	
	def GetSelectedMode():
		return selectedMode

	def OnGUI():
		GUI.BeginGroup(Rect(elementPosition.x,elementPosition.y,300,50))
		selectedMode = GUI.SelectionGrid(Rect(0,0,300,50),selectedMode,("Place/Remove","Inspect","Other"),3)
		
		GUI.EndGroup()