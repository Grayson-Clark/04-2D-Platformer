extends Node2D

onready var Player = load("res://Player/Player.tscn")
var starting_position = Vector2(200,200)


func _process(_delta):
	if not has_node("Player"):
		respawn_player()

func respawn_player():
	var player = Player.instance()
	var StartPortal = get_node_or_null("../StartPortal")
	if StartPortal:
		player.position = StartPortal.position
	else:
		player.position = starting_position
	add_child(player)
	player.score = Global.save_data["general"]["score"]
	Global.update_score(player.score)


func _on_AudioStreamPlayer2D_finished():
	get_node("../AudioStreamPlayer2D").play()
