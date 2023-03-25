extends Node

#Access with DCheck.distance()

func distance(obj1, obj2, obj3):
	var dx = obj2.x - obj1.x
	var dx2 = obj3.x - obj1.x
	var dy = obj2.y - obj1.y
	var dy2 = obj3.y - obj1.y
	var dz = obj2.z - obj1.z
	var dz2 = obj3.z - obj1.z
	if(sqrt(dx * dx + dy * dy + dz * dz) > sqrt(dx2 * dx2 + dy2 * dy2 + dz2 * dz2)):
		return true
	return false
	
func distance2 (obj1, obj2):
	var dx = obj2.x - obj1.x
	var dy = obj2.y - obj1.y
	var dz = obj2.z - obj1.z
	return(sqrt(dx * dx + dy * dy + dz * dz))
	
func angle(obj1, obj2, obj3):
	var a = distance2(obj1,obj2)
	var b = distance2(obj1,obj3)
	var c = distance2(obj3,obj2)
	print("A: " + str(a))
	print("B: " + str(b))
	print("C: " + str(c))
	if(a != 0):
		return acos((c*c-b*b-a*a)/(-2*a))
	return -1
