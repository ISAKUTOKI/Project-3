extends Node

@onready var target: MeshInstance3D = $"../View"
@export_color_no_alpha var color: Color = Color(1, 1, 1, 1)
@export_range(1.0, 1.5) var thickness: float = 1.07

var material: StandardMaterial3D
var material_next_pass: ShaderMaterial


func initialize_node() -> void:
	var _original_mat := target.mesh.surface_get_material(0)
	# 副本化material
	var _material_copy = _original_mat.duplicate(true)
	# 副本化material的next_pass
	var _material_next_pass_copy = _original_mat.next_pass.duplicate(true)
	_material_copy.next_pass = _material_next_pass_copy
	# 设置材质
	target.set_surface_override_material(0, _material_copy)
	# 设置变量
	material = target.get_surface_override_material(0)
	print(material)
	# TODO 为什么会是空值呢？为什么呢？？？？？？？？
	material_next_pass = material.next_pass
	print(material_next_pass)
	# 初始化
	_initialize()


func _initialize():
	if material_next_pass == null:
		return
	material_next_pass.set_shader_parameter("color", color)
	material_next_pass.set_shader_parameter("thickness", thickness)
	hide()


func show():
	material_next_pass.set_shader_parameter("color", color)


func hide():
	material_next_pass.set_shader_parameter("color", Color(color.r, color.g, color.b, 0))
	#print("隐藏了边缘线，来自于： ", get_parent().name)

# TODO 修好这个该死的材质系统
