extends CharacterBody2D

@export var MovementSpeed = 70
@export var Friction = .9
@export var objOffset = Vector2.ZERO

@onready var Sprite = get_node("Sprite2D")

var obj = null
var talk = null
var objGrabbed = false
var movement = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("Haunt"): Haunt()
	
	movement.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	movement.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	velocity = (velocity + movement * MovementSpeed) * Friction
	Sprite.flip_h = sign(velocity.x) == 1
	move_and_slide()

func Haunt():
	if obj != null:
		obj.Prompt(!objGrabbed)
		if !objGrabbed:
			objGrabbed = true
			GD.Reparent(obj, self)
			obj.position = objOffset
			collision_layer = 1 ; collision_mask = 1
		else:
			objGrabbed = false
			GD.Reparent(obj)
			await get_tree().process_frame
			obj.position = position + objOffset
			collision_layer = 0 ; collision_mask = 0
	
	if talk != null:
		talk.Next()



func _on_area_entered(area):
	if area.is_in_group("Object") && !objGrabbed:
		obj = area
		obj.Prompt(false)
	elif area.is_in_group("Talk"):
		talk = area
		talk.Prompt(false)

func _on_area_exited(area):
	if area.is_in_group("Object") && !objGrabbed:
		obj.Prompt(true)
		obj = null
	elif area.is_in_group("Talk"):
		talk.Prompt(true)
		talk = null
