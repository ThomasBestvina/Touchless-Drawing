extends Node2D

onready var tracker = $Tracker
var brushtest = preload("res://TempBrush.tscn")

var resolution = OS.get_screen_size()

var x = 0.1
var y = 0.1

func _process(_delta):
	
	x = lerp(x,(1-tracker.update_hand(0,0,0)*1024),0.3)
	y = lerp(y,tracker.update_hand(0,0,1)*600,0.3)
	var newPaint = brushtest.instance()
	add_child(newPaint)
	newPaint.position = Vector2(x,y)
	

