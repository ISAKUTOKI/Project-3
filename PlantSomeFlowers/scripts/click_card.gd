extends Node

@onready var ray_cast: RayCast3D = $"../RayCast"
var is_dragging: bool = false


func _pick_up_card():
	if ray_cast.target is Card and Input.is_action_just_pressed("click"):
		ray_cast.target.drag_card()


func _drop_card():
	if is_dragging:
		if Input.is_action_just_released("click") and not ray_cast.target == Flower:
			ray_cast.target.drop_card()
		elif Input.is_action_just_pressed("cancel"):
			ray_cast.target.drop_card()
