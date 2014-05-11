import UnityEngine

class MainMenu (MonoBehaviour):
	
	public Levels as (TextAsset)
	showInstructions = false
	public instructions as TextAsset

	def OnGUI():
		h = Screen.height
		w = Screen.width
		GUI.BeginGroup(Rect((w-400)/2,100,400,400))
		if showInstructions:
			GUI.Box(Rect(0,0,400,340),"")
			GUI.Label(Rect(10,0,380,340),instructions.text)
			if GUI.Button(Rect(0,350,400,40),"OK"):
				showInstructions = false
		else:
			vert = 0
			for item in Levels:
				if GUI.Button(Rect(0,vert,400,40),"Play " + item.name):
					Globals.levelData = item
					Globals.loadFromTextAsset = true
					Application.LoadLevel("levelview")
				vert = vert + 50
			if GUI.Button(Rect(0,vert,400,50),"Instructions"):
				showInstructions = true
		GUI.EndGroup()
