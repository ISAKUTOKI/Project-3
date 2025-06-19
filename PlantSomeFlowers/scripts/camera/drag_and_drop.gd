extends Node

@onready var camera: Camera3D = $".."
var is_dragging: bool = false
var current_card = null
var drag_plane := Plane(Vector3.UP, 0)  # 拖拽平面
var drag_offset := Vector3.ZERO        # 初始拾取偏移

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_drag_card()
		_drop_card()
	# 拖拽时的持续移动检测
	if is_dragging and event is InputEventMouseMotion:
		_update_drag_position()

func _drag_card():
	if camera.current_target == null: return
	
	if camera.current_target.is_in_group("Card") and Input.is_action_just_pressed("drag"):
		current_card = camera.current_target
		current_card.card_is_dragged()
		is_dragging = true
		
		# 计算拖拽平面和偏移
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_dir = camera.project_ray_normal(mouse_pos)
		
		# 以卡片当前高度创建拖拽平面
		drag_plane = Plane(Vector3.UP, current_card.global_position.y)
		var intersection = drag_plane.intersects_ray(ray_origin, ray_dir)
		
		if intersection:
			drag_offset = current_card.global_position - intersection

func _update_drag_position():
	if !current_card: return
	
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_dir = camera.project_ray_normal(mouse_pos)
	
	# 计算鼠标在拖拽平面上的位置
	var new_pos = drag_plane.intersects_ray(ray_origin, ray_dir)
	if new_pos:
		# 应用偏移并更新位置
		current_card.global_position = new_pos + drag_offset
		
		# 使卡片轻微面向相机
		current_card.look_at(camera.global_position, Vector3.UP)
		current_card.rotation.x = 0 # 保持水平
		current_card.rotation.z = 0

func _drop_card():
	if is_dragging and (Input.is_action_just_released("drag") or Input.is_action_just_pressed("drop")):
		if camera.current_target is Flower:  # 如果目标是花
			current_card.card_is_used()
		else:
			current_card.card_is_dropped()
		
		is_dragging = false
		current_card = null
