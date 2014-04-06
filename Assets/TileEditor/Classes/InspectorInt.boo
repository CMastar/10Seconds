import UnityEngine

class InspectorInt (MonoBehaviour):
	public elementPosition as Vector2
	tileParameters as Hash
	scrollPosition as Vector2 = Vector2.zero
	inspectedTile as GameObject

	def Start ():
		tileParameters = Hash()

	


	def OnGUI():
		GUI.BeginGroup(Rect(elementPosition.x,elementPosition.y,200,300))
		GUI.Box(Rect(0,0,200,300),"Tile Inspector")
		scrollPosition = GUI.BeginScrollView(Rect(5,40,190,200), scrollPosition, Rect(0,0,190, tileParameters.Count * 40))
		if tileParameters != null:
			i = 0
			newParams = Hash()
			for item in tileParameters:
				GUI.Label(Rect(0, i * 40, 80, 30), item.Key cast string)
				if item.Value isa string:
					item.Value = GUI.TextField(Rect(90, i * 40, 80, 30), item.Value)
				if item.Value isa Vector3:
					position as Vector3 =  item.Value
					position.x  = single.Parse(GUI.TextField(Rect(90, i * 40, 30, 30), position.x.ToString()))
					position.y = single.Parse(GUI.TextField(Rect(125, i * 40, 30, 30), position.y.ToString()))
					position.z = single.Parse(GUI.TextField(Rect(160, i * 40, 30, 30), position.z.ToString()))
					item.Value = position
				if item.Value isa long:
					item.Value = long.Parse(GUI.TextField(Rect(90, i * 40, 80, 30), item.Value.ToString()))
				if item.Value isa bool:
					item.Value = GUI.Toggle(Rect(90, i * 40, 50, 50),item.Value,"Yes")
				i = i + 1
				newParams[item.Key] = item.Value
			tileParameters = newParams
		GUI.EndScrollView()
		if GUI.Button(Rect(10,250,85,40),"Make Changes") or Input.GetKeyUp("return"):
			inspectedTile.GetComponent[of BaseTile]().SetParameters(tileParameters)
			Inspect(inspectedTile)
		if GUI.Button(Rect(105,250,85,40),"Delete Tile") or Input.GetKeyUp(KeyCode.Delete):
			GameObject.Destroy(inspectedTile)
		GUI.EndGroup()
		
	public def Inspect(tile as GameObject):
		inspectedTile = tile
		tileParameters = tile.GetComponent[of BaseTile]().GetParameters()