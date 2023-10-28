extends Node

@onready var Points = get_tree().get_nodes_in_group("Point")
@onready var Root = get_node("/root").get_child(get_node("/root").get_child_count()-1)

func Reparent(obj, parent = Root):
	if obj.get_parent(): obj.get_parent().remove_child(obj)
	return parent.call_deferred("add_child", obj)
