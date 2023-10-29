extends Area2D

@export var Scene: String
@export var Position = Vector2.ZERO
var playerIn = false

func _ready(): Scene = Scene.replace('"', "")

func _on_area_entered(area):
	playerIn = true
	Prompt(false)
func _on_area_exited(area):
	playerIn = false
	Prompt(true)

func Prompt(drop):
	var t = create_tween().set_trans(Tween.TRANS_EXPO)
	if !drop:
		t.tween_property($Sprite2D2, "scale", Vector2.ONE*2, .2)
	else:
		t.tween_property($Sprite2D2, "scale", Vector2.ZERO, .2)

func _input(event): if playerIn && Input.is_action_just_pressed("Haunt"): NextScene()

func NextScene():
	GD.Player.canMove = false
	await UI.Trans1()
	get_tree().change_scene_to_file(Scene)
	UI.Trans2()
	GD.Player.position = Position
