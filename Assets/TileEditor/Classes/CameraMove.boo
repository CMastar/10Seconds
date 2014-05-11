import UnityEngine

class CameraMove (MonoBehaviour):
	//public altCam as Camera
	public cameraspeed as int
	public scrollspeed as int

	def Start ():
		pass
	
	def Update ():
		transform.Translate((Input.GetAxis('Horizontal') * cameraspeed * Time.deltaTime),(Input.GetAxis('Vertical') * cameraspeed * Time.deltaTime),0)
		camera.orthographicSize = camera.orthographicSize - (Input.GetAxis('Mouse ScrollWheel') * scrollspeed)
		/*if Input.GetKey('space'):
			altCam.enabled = true
			camera.enabled = false */
