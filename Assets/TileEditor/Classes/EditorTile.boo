import UnityEngine

class EditorTile (MonoBehaviour):
	tileModifier as TileModifier
	originalColour as Color

	def Awake():
		tileModifier = GameObject.Find("manager").GetComponent[of TileModifier]()
		originalColour = renderer.material.color
		
	def DeSelect():
		renderer.material.color = originalColour
	
	def OnMouseDown():
		tileModifier.OnEditorTileClicked(gameObject)
		renderer.material.color = Color(0,1,0,0.5)