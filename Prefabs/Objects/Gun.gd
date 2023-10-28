extends Area2D

var charged = false
@onready var Obj = get_parent()

func _physics_process(delta):
	$CollisionShape2D.disabled = Obj.pickedUp
	if Obj.pickedUp:
		scale.x = sign(GD.Player.velocity.x)
		position = Vector2(30 * scale.x, 0)
	else: position = Vector2.ZERO

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
