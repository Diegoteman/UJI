extends Area2D

var charged = false
@onready var Obj = get_parent()

func _physics_process(delta):
	$CollisionShape2D.disabled = Obj.pickedUp
	if Obj.pickedUp:
		var dir = sign(GD.Player.velocity.x)
		if dir != 0 :scale.x = dir
		position = Vector2(30 * scale.x, 0)

func _input(event):
	if Obj.pickedUp && charged && Input.is_action_just_pressed("Haunt"):
		Shoot()

func Shoot():
	$Sprite2D/AnimationPlayer.play("Shoot")
	charged = false
	$Shot/CollisionShape2D.disabled = false
	$Shot/Timer.start()
	await $Shot/Timer.timeout
	$Shot/CollisionShape2D.disabled = true
	$Sprite2D/AnimationPlayer.play("Empty")


func _on_shot_area_entered(area):
	if area.is_in_group("Scared"):
		area.Die()


func _on_gun_area_entered(area):
	if area.is_in_group("Pool"):
		charged = true
		$Sprite2D/AnimationPlayer.play("Full")
