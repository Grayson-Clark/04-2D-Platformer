extends Node

var current_level = 0
const FINAL_LEVEL = 3

func load_next_level():
	current_level += 1
	save_data["general"]["level"] = current_level
	
	if current_level == FINAL_LEVEL:
		#get_tree().change_scene("res://Levels/EndGame.tscn")
		SceneHolder.change_scene("res://Levels/EndGame.tscn")
	elif current_level > FINAL_LEVEL:
		get_tree().quit()
	else:
		#get_tree().change_scene("res://Levels/" + str(current_level) + ".tscn")
		SceneHolder.change_scene("res://Levels/" + str(current_level) + ".tscn")


# ----------------------------------------------

const SAVE_PATH = "user://savegame.tscn"
const SECRET = "C220 Is the Best!"

onready var SceneHolder = get_node_or_null("/root/SceneHolder")
onready var Coins = get_node_or_null("/root/SceneHolder/Game/Coins")
onready var Mines = get_node_or_null("/root/SceneHolder/Game/Mines")
onready var Game = load("res://Game.tscn")
onready var Coin = load("res://Coin/Coin.tscn")
onready var Mine = load("res://Mine/Mine.tscn")

var save_data = {
	"general": {
		"level":0,
		"score":0,
		"health":100,
		"coins":[],
		"mines":[]
	}
}

func update_score(s):
	var HUD = get_node_or_null("/root/SceneHolder/Game/UI/HUD")
	var Player = get_node_or_null("/root/SceneHolder/Game/Player_Container/Player")
	if Player != null and HUD != null:
		save_data["general"]["score"] = s
		Player.score = s
		HUD.find_node("Score").text = "Score: " + str(Player.score)

func update_health(h):
	var HUD = get_node_or_null("/root/SceneHolder/Game/UI/HUD")
	var Player = get_node_or_null("/root/SceneHolder/Game/Player_Container/Player")
	if Player != null and HUD != null:
		save_data["general"]["health"] = h
		Player.health = h
		if Player.health <= 0:
			Player.die()
		HUD.find_node("Health").text = "Health: " + str(Player.health)

# ----------------------------------------------------------

func save_game():
	var scene = PackedScene.new()
	var scene_root = get_node("/root/SceneHolder/Game")
	_set_owner(scene_root, scene_root)
	scene.pack(scene_root)
	ResourceSaver.save(SAVE_PATH, scene) # or .scn to avoid people messing with it
	
func load_game():
	var game = get_node("/root/SceneHolder/Game")
	game.queue_free()
	SceneHolder.remove_child(game)
	var loaded_scene = load(SAVE_PATH).instance()
	SceneHolder.add_child(loaded_scene)
	
	var Player = get_node_or_null("/root/SceneHolder/Game/Player_Container/Player")

	update_score(Player.score)
	update_health(Player.health)
	
	get_tree().paused = false


func _set_owner(node, root):
	if node != root:
		node.owner = root
	for child in node.get_children():
		if is_instanced_from_scene(child)==false:
			_set_owner(child, root)
		else:
			child.owner = root


func is_instanced_from_scene(p_node):
	if not p_node.filename.empty():
		return true
	return false
