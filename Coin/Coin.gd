extends Area2D

onready var Player = get_node_or_null("/root/SceneHolder/Game/Player_Container/Player")

var score = 10

func _on_Coin_body_entered(body):
	if body.name == "Player":
		Global.update_score(body.score + score)
		queue_free()
