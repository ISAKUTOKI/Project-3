extends Node

@onready var camera: Camera3D = $".."
var is_dragging: bool = false
var current_card = null
@export var drag_distance: float = 1.5  # 拖拽时离相机的距离


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_drag_card()
		_drop_card()

	if is_dragging and event is InputEventMouseMotion:
		_update_drag_position()


func _drag_card():
	if camera.current_target == null:
		return

	if camera.current_target.is_in_group("Card") and Input.is_action_just_pressed("drag"):
		current_card = camera.current_target
		current_card.card_is_dragged()
		is_dragging = true


func _update_drag_position():
	if !current_card:
		return

	# 计算固定距离的位置
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_dir = camera.project_ray_normal(mouse_pos)
	current_card.global_position = camera.global_position + ray_dir * drag_distance
	
	# 获取相机y轴旋转旋转（只取Y轴）
	var camera_rotation = camera.global_transform.basis.get_euler()
	
	# 应用旋转（保持卡片自身X/Z轴旋转，仅同步Y轴旋转）
	current_card.rotation = Vector3(
		current_card.rotation.x,  # 保持原有X轴旋转（如需要倾斜效果）
		camera_rotation.y,        # 同步相机Y轴旋转
		current_card.rotation.z   # 保持原有Z轴旋转
	)



func _drop_card():
	if is_dragging and (Input.is_action_just_released("drag") or Input.is_action_just_pressed("drop")):
		if camera.current_target is Flower:  # 假设Flower是花的类型
			current_card.card_is_used()
			GlobalSignalBus.card_used.emit(current_card)
		else:
			current_card.card_is_dropped()

		is_dragging = false
		current_card = null
