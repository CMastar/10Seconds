import UnityEngine

class MachineSpawner (TriggerableTile): 
	public machineToSpawn as GameObject

	def Reset():
		unless machineToSpawn == null:
			Object.Destroy(triggeredObject)
		triggeredObject = Instantiate(machineToSpawn,transform.position,transform.rotation)
		
