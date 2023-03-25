extends Node

#Access with DCheck.distance()

func distance(x_2, x_1, y_2, y_1, z_2, z_1):
	var dx = x_2 - x_1
	var dy = y_2 - y_1
	var dz = z_2 - z_1
	return sqrt(dx * dx + dy * dy + dz * dz)
