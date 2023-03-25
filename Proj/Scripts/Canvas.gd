extends Node2D

onready var tracker = $Tracker
var brushtest = preload("res://Scenes/TempBrush.tscn")
var eraser = preload("res://Scenes/Eraser.tscn")

var resolution = OS.get_screen_size()

var x = 0.1
var y = 0.1
var z = 0
var val = 0

func _process(_delta):
	x = lerp(x,(1-tracker.update_hand(0,0,0)*resolution.x),0.3)
	y = lerp(y,tracker.update_hand(0,0,1)*resolution.y,0.3)
	
	var indexFinger = Vector3(1-tracker.update_hand(0,0,0),tracker.update_hand(0,0,1),tracker.update_hand(0,0,2))
	var thumbBase = Vector3(1-tracker.update_hand(0,1,0),tracker.update_hand(0,1,1),tracker.update_hand(0,1,2))
	var middleFinger = Vector3(1-tracker.update_hand(0,2,0),tracker.update_hand(0,2,1),tracker.update_hand(0,2,2))
	var ringFinger = Vector3(1-tracker.update_hand(0,3,0),tracker.update_hand(0,3,1),tracker.update_hand(0,3,2))
	
	var middle_pip = Vector3(1-tracker.update_hand(0,4,0),tracker.update_hand(0,4,1),tracker.update_hand(0,4,2))
	var middle_dip = Vector3(1-tracker.update_hand(0,5,0),tracker.update_hand(0,5,1),tracker.update_hand(0,5,2))
	
	z = abs(tracker.update_hand(0,0,2))

	val = DCheck.dotTest((indexFinger-ringFinger).normalized(),(thumbBase-middleFinger).normalized(), (middle_pip-middle_dip).normalized() )
	
	
	if(val == 1):
		var newPaint = brushtest.instance()
		add_child(newPaint)
		newPaint.position = Vector2(x,y)
		if(z != 0):
			newPaint.scale = Vector2(z*10,z*10)
	if(val == 2):
		var newEraser = eraser.instance()
		add_child(newEraser)
		newEraser.position = Vector2(x,y)
		if(z != 0):
			newEraser.scale = Vector2(z,z)
	$Sprite2.position = Vector2(x,y)

