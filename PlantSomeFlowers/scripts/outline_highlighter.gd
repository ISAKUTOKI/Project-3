extends Node

@onready var target: MeshInstance3D = $"../View"
@export_color_no_alpha var color: Color = Color(1, 1, 1, 1)
@export_range(1.0, 1.5) var thickness: float = 1.03

var material: ShaderMaterial


func _ready() -> void:
	material = target.get_active_material(0).next_pass
	_initialize()


func _initialize():
	if not material:
		return
	material.set_shader_parameter("color", color)
	material.set_shader_parameter("thickness", thickness)


func show():
	material.set_shader_parameter("color", color)


func hide():
	material.set_shader_parameter("color", Color(1, 1, 1, 0))
