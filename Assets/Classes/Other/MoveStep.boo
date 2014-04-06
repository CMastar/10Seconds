import UnityEngine

class MoveStep (ValueType): 

	public time as double
	public action as string
	public direction as Vector3

	def constructor(inTime as double,inAction as String, inDirection as Vector3):
		time = inTime
		action = inAction
		direction = inDirection
		
	def constructor(inTime as double, inAction as String):
		time = inTime
		action = inAction