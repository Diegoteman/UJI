extends Node2D

@onready var Obj = get_parent()

func _process(delta):
	$Sprite2D2/Sprite2D.visible = Obj.pickedUp
	$CollisionShape2D.disabled = !Obj.pickedUp
	if Obj.pickedUp: rotation = lerp(rotation, GD.Player.velocity.angle() - PI/2, .5)

func _on_area_entered(area):
	if area.name == "Freddy": area.Die()
