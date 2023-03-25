extends Node

#Access with DCheck.distance()

func distance(obj1, obj2):
	var dx = obj2.x - obj1.x
	var dy = obj2.y - obj1.y
	var dz = obj2.z - obj1.z
	return sqrt(dx * dx + dy * dy + dz * dz)
