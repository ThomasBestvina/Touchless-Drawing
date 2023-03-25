extends Node2D

onready var tracker = $Tracker
var brushtest = preload("res://TempBrush.tscn")

var resolution = OS.get_screen_size()

var x = 0.1
var y = 0.1

func _process(_delta):
	x = lerp(x,(1-tracker.update_hand(0,0,0)*resolution.x),0.35)
	y = lerp(y,tracker.update_hand(0,0,1)*resolution.y,0.35)
	
	var indexFinger = Vector3(1-tracker.update_hand(0,0,0),tracker.update_hand(0,0,1),tracker.update_hand(0,0,2))
	var thumbBase = Vector3(1-tracker.update_hand(0,1,0),tracker.update_hand(0,1,1),tracker.update_hand(0,1,2))
	var middleFinger = Vector3(1-tracker.update_hand(0,2,0),tracker.update_hand(0,2,1),tracker.update_hand(0,2,2))
	var ringFinger = Vector3(1-tracker.update_hand(0,3,0),tracker.update_hand(0,3,1),tracker.update_hand(0,3,2))
	var pinkyFinger = Vector3(1-tracker.update_hand(0,4,0),tracker.update_hand(0,4,1),tracker.update_hand(0,4,2))
	
	#"print(DCheck.distance(thumbBase,indexFinger,middleFinger))"
	
	#print(DCheck.angle(indexFinger,middleFinger,thumbBase))
	
	var canDraw = DCheck.distance(thumbBase,indexFinger,middleFinger)
	
	
	
	if(canDraw):
		var newPaint = brushtest.instance()
		add_child(newPaint)
		newPaint.position = Vector2(x,y)
