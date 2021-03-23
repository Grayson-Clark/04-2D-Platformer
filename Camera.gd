extends Camera2D

func _process(_delta):
	var player = get_node_or_null("../Player_Container/Player")
	if player != null:
		position = player.position
