extends Control

onready var Player = get_node_or_null("/root/SceneHolder/Game/Player_Container/Player")

func _ready():
	if Player != null:
		Global.update_health(Player.health)
		Global.update_score(Player.score)
