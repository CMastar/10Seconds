import UnityEngine

class ItemTile (TriggerableTile): 

	public itemToSpawn as GameObject
	public spawnOnTrigger = false
	spawnedItem as GameObject
	
	def SpawnItem():
		unless spawnedItem == null:
			Object.Destroy(spawnedItem)
		spawnedItem = Instantiate(itemToSpawn,transform.position,transform.rotation)
		
	def Reset():
		//print(gameObject.name + " being reset, spawnOnTrigger is " + spawnOnTrigger)
		if spawnOnTrigger:
			unless spawnedItem == null:
				Object.Destroy(spawnedItem)
		else:
			SpawnItem()
		
	def Trigger():
		SpawnItem()
		//triggeredObject.GetComponent[of Triggerable]().Trigger()
	
