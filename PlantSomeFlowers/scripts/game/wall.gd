extends Node

var wall_list := []
@export var wall_offset: Vector3 = Vector3(0, 0, -0.7)  # x, y, z
@export var wall_scale: Vector3 = Vector3(0.5, 0.5, 0.5)  # x, y, z
var wall: Sprite3D


func _ready() -> void:
	_initialize()
	_rank_wall()


func _initialize():
	wall_list = get_children()
	for i: Sprite3D in wall_list:
		i.scale = wall_scale
		i.billboard = BaseMaterial3D.BILLBOARD_DISABLED
		i.alpha_cut = SpriteBase3D.ALPHA_CUT_OPAQUE_PREPASS
		i.shaded = true
		#i.material_override = preload("res://material/wall_material.tres")


func _rank_wall():
	var count: int = 0
	for i: Sprite3D in wall_list:
		i.position = Vector3(0, 0, 0) + count * wall_offset
		count += 1
