extends Node2D


func _ready():
	add_child(load("res://Game.tscn").instance())

# this causes longer load times when changing levels. Considering this is only 2 levels, I could just preload them here based on the scenes in the Levels folder
func change_scene(path):
	$Game.queue_free()
	remove_child($Game)
	add_child(load(path).instance())

