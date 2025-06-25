extends Node

@onready var target: MeshInstance3D = $"../View"
@export_color_no_alpha var color: Color = Color(1, 1, 1, 1)
@export_range(1.0, 1.5) var thickness: float = 1.07

var material: ShaderMaterial


func _ready() -> void:
	# 获取原始材质并创建独立副本
	var original_material = target.get_active_material(0)
	if original_material:
		# 复制主材质和它的next_pass
		var material_copy = original_material.duplicate()
		if original_material.next_pass:
			material_copy.next_pass = original_material.next_pass.duplicate()
		target.set_surface_override_material(0, material_copy)
		material = material_copy.next_pass
	_initialize()


func _initialize():
	if material == null:
		return
	material.set_shader_parameter("color", color)
	material.set_shader_parameter("thickness", thickness)


func show():
	if material:
		material.set_shader_parameter("color", color)


func hide():
	if material:
		material.set_shader_parameter("color", Color(color.r, color.g, color.b, 0))
