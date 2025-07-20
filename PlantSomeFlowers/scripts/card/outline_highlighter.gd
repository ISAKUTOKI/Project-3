extends Node

@onready var target: MeshInstance3D = $"../View"
@export_color_no_alpha var color: Color = Color(1, 1, 1, 1)
@export_range(1.0, 1.5) var thickness: float = 1.07

var material_next_pass: ShaderMaterial = null

func initialize_node() -> void:
	# 记录原材质
	var _original_mat := target.mesh.surface_get_material(0)
	# 实例化材质
	var _material_copy := _original_mat.duplicate(true)
	# 设置描边shader
	var _outline_shader := preload("res://shaders/model_based_outline.gdshader")
	var _material_next_pass_copy := ShaderMaterial.new()
	_material_next_pass_copy.shader = _outline_shader
	# 设置参数
	_material_next_pass_copy.set_shader_parameter("color", color)
	_material_next_pass_copy.set_shader_parameter("thickness", thickness)
	# 设置next_pass
	_material_copy.next_pass = _material_next_pass_copy
	# 设置材质
	target.set_surface_override_material(0, _material_copy)
	#设置核心变量
	material_next_pass = _material_next_pass_copy

	_initialize()

func _initialize():
	material_next_pass.set_shader_parameter("color", color)
	material_next_pass.set_shader_parameter("thickness", thickness)
	#print(get_parent().name,"   ",material_next_pass)
	hide()

func show():
	material_next_pass.set_shader_parameter("color", color)

func hide():
	material_next_pass.set_shader_parameter("color", Color(color.r, color.g, color.b, 0))
