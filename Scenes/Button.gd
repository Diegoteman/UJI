extends Button

@onready var Sprite = get_child(0)

func _on_mouse_entered():
	Sprite.modulate = Color.WHITE * 1.05


func _on_focus_entered():
	Sprite.modulate = Color.WHITE * 1.1
