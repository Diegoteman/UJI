extends Node

@onready var Points = get_tree().get_nodes_in_group("Point")
var Root
var Player
var FirstTime = false

var freddyDead = false
var peaDead = false
var femboyDead = false

func _ready(): FindRoot()
func FindRoot(): Root = get_node("/root").get_child(get_node("/root").get_child_count()-1)

func Reparent(obj, parent = Root):
	if !is_instance_valid(Root): FindRoot()
	if obj.get_parent(): obj.get_parent().call_deferred("remove_child", obj)
	parent.call_deferred("add_child", obj)
	return obj

func _input(event):
	if !Input.is_action_just_released("Fullscreen"): return
	
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
