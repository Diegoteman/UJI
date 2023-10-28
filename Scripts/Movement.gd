extends Area2D

@export var MovementSpeed = 70
@export var Friction = .9
@export var objOffset = Vector2.ZERO

var obj = null
var talk = null
var objGrabbed = false
var movement = Vector2.ZERO
var velocity = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	movement.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	movement.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	velocity = (velocity + movement * MovementSpeed) * Friction
	if velocity.x != 0: scale.x = -sign(velocity.x)
	position += velocity * delta
	
	if Input.is_action_just_pressed("Haunt"): Haunt()

func Haunt():
	if obj == null: return
	
	obj.Grab(objGrabbed)
	if !objGrabbed:
		objGrabbed = true
		GD.Reparent(obj, self)
		obj.position = objOffset
	else:
		objGrabbed = false
		GD.Reparent(obj)
		await get_tree().process_frame
		obj.position = position + objOffset



func _on_area_entered(area):
	if area.is_in_group("Object"):
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
		talk = null
		talk.Prompt(true)
