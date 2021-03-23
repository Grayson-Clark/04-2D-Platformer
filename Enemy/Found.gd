extends Node

onready var SM = get_parent()
onready var enemy = get_node("../..")

onready var player = null
onready var ray = enemy.get_node("RayCast2D")
onready var laser = enemy.get_node("Laser")

func _ready():
	yield(enemy, "ready")

func physics_process(_delta):
	if player == null:
		player = get_node("/root/SceneHolder/Game/Player_Container/Player")
	else:	
		var player_pos = ray.to_local(player.global_position)
		ray.cast_to = player_pos
		var ang = wrapf(rad2deg(laser.points[0].angle_to_point(laser.points[1])),0,360)
		if ang <= 180:
			enemy.set_turret_angle(ang)
		enemy.update_laser(enemy.to_local(ray.get_collision_point()),true)
		var c = ray.get_collider()
		if c and not c.name == "Player":
			SM.set_state("Scanning")
		else:
			player.die()
