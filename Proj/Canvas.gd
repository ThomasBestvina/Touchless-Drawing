extends Node2D

onready var tracker = $Tracker

func _process(_delta):
	tracker.update_hand(0,8,0)
