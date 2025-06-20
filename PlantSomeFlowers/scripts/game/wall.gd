@tool
extends Node

var wall_list := []
@export var wall_initial_pos: Vector3 = Vector3(0, 0, 2.3)  # x, y, z
@export var wall_offset: Vector3 = Vector3(0, 0, -0.5)  # x, y, z
@export var wall_scale: Vector3 = Vector3(0.7, 0.7, 0.7)  # x, y, z


func _ready() -> void:
	_get_wall_list()
	if Engine.is_editor_hint():
		_initialize()
		_rank_wall()
		return
	GlobalSignalBus.start_shake.connect(_on_start_shake)
	GlobalSignalBus.stop_shake.connect(_on_stop_shake)


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if is_shaking:
		_shaking(delta)


func _initialize():
	for wall in wall_list:
		wall.scale = wall_scale
		wall.billboard = BaseMaterial3D.BILLBOARD_DISABLED
		wall.alpha_cut = SpriteBase3D.ALPHA_CUT_OPAQUE_PREPASS
		wall.shaded = true
		wall.set_meta("original_pos", wall.position)


func _rank_wall():
	var count: int = 0
	for wall in wall_list:
		wall.position = wall_initial_pos + count * wall_offset
		count += 1


func _get_wall_list():
	wall_list = get_children()


#region 墙的震动相关逻辑
class WallShakeParams:
	var phase: float = 0
	var speed: float = randf_range(15.0, 25.0)
	var x_mult: float = randf_range(0.8, 1.2)
	var y_mult: float = randf_range(0.8, 1.2)


var wall_shake_params := {}
var is_shaking: bool = false
var shake_strength: float = 0


func _on_start_shake(strength: GameManager.ShakeType):
	shake_strength = GameManager.SHAKE_STRENGTH[strength]
	is_shaking = true
	print("开始震动： ", self.name)
	# 初始化每个墙体的震动参数
	wall_shake_params.clear()
	for wall in wall_list:
		wall_shake_params[wall.get_instance_id()] = WallShakeParams.new()


func _shaking(delta: float):
	if shake_strength <= 0:
		return

	for wall in wall_list:
		if wall.has_meta("original_pos") and wall_shake_params.has(wall.get_instance_id()):
			var params = wall_shake_params[wall.get_instance_id()]
			params.phase += delta * params.speed

			# 计算独立震动偏移量
			var shake_offset = Vector3(sin(params.phase * 1.2) * 0.2 * params.x_mult * shake_strength, cos(params.phase * 0.8) * 0.4 * params.y_mult * shake_strength, 0)  # Z轴保持不变
			wall.position = wall.get_meta("original_pos") + shake_offset


func _on_stop_shake():
	print("停止震动： ", self.name)
	var tween = create_tween().set_parallel(true)
	for wall in wall_list:
		if wall.has_meta("original_pos"):
			tween.tween_property(wall, "position", wall.get_meta("original_pos"), 0.2)
	is_shaking = false
	wall_shake_params.clear()
#endregion
