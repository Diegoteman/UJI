extends CharacterBody2D

@export var MovementSpeed = 70
@export var Friction = .9
@export var objOffset = Vector2.ZERO

@onready var Sprite = get_node("Sprite2D")

var obj = null
var talk = null
var objGrabbed = false
var canMove = true

func _enter_tree():
	GD.Player = self
	GD.FindRoot()

func _physics_process(delta):
	if Input.is_action_just_pressed("Haunt"): Haunt()
	var movement = Vector2.ZERO
	if canMove:
		movement.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		movement.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	velocity = (velocity + movement * MovementSpeed) * Friction
	Sprite.flip_h = sign(velocity.x) == 1
	if objGrabbed: obj.position = objOffset ; if Sprite.flip_h: obj.position.x *= -1
	move_and_slide()

func Haunt():
	if obj != null:
		obj.Prompt(!objGrabbed)
		obj.pickedUp = !objGrabbed
		if !objGrabbed:
			objGrabbed = true
			modulate.a = 1
			$Sprite2D/AnimationPlayer.play("Grab")
			GD.Reparent(obj, self)
			obj.position = objOffset
			collision_layer = 3 ; collision_mask = 3
		else:
			objGrabbed = false
			modulate.a = .63
			$Sprite2D/AnimationPlayer.play("Idle")
			GD.Reparent(obj)
			collision_layer = 1 ; collision_mask = 1
			await get_tree().process_frame
			if !obj: return
			obj.position = position - objOffset * sign(velocity.x)
	
	if talk != null && !objGrabbed && !obj:
		talk.Next()



func _on_area_entered(area):
	if area.is_in_group("Object") && !objGrabbed:
		obj = area
		obj.Prompt(false)
	elif area.is_in_group("Talk"):
		talk = area
		talk.Prompt(false)

func _on_area_exited(area):
	if area.is_in_group("Object") && !objGrabbed && obj:
		obj.Prompt(true)
		obj = null
	elif area.is_in_group("Talk") && talk:
		talk.Prompt(true)
		talk = null

func Scare():
	$Sprite2D2.flip_h = Sprite.flip_h
	if !Sprite.flip_h: $Sprite2D2.position.x = -30
	else: $Sprite2D2.position.x = 30
	Sprite.visible = false
	$Sprite2D2.visible = true
	$Sprite2D2/AnimationPlayer.play("scare")
	await create_tween().tween_property(self, "scale", scale, 2.6).finished
	$Sprite2D2/AnimationPlayer.play("RESET")
	Sprite.visible = true
	$Sprite2D2.visible = false
