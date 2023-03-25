extends Node2D

onready var tracker = $Tracker

func _process(_delta):
	print(tracker.update_hand(0,0,0))
	pass
