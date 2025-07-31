extends Node
@onready var camera: Camera3D = $".."
var is_dragging: bool = false
var current_card: Card = null
@export var drag_distance: float = 1.5  # 拖拽时离相机的距离
var mouse_pos
var ray_dir


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
		# 初始化tween动画更新位置防止过于突兀
		mouse_pos = get_viewport().get_mouse_position()
		ray_dir = camera.project_ray_normal(mouse_pos)
		var tween = create_tween()
		tween.tween_property(
			current_card, "global_position", camera.global_position + ray_dir * drag_distance, 0.05
		)


func _update_drag_position():
	if current_card == null:
		return
	# 计算固定距离的位置
	mouse_pos = get_viewport().get_mouse_position()
	ray_dir = camera.project_ray_normal(mouse_pos)
	current_card.global_position = camera.global_position + ray_dir * drag_distance
	#print(current_card.global_position)
	current_card.look_at(camera.position, Vector3(0, 1, 0), true)


func _drop_card():
	if is_dragging and (Input.is_action_just_released("drag") or Input.is_action_just_pressed("drop")):
		if camera.current_target is Flower or camera.current_target is Option:  # 如果目标为花
			current_card.card_is_used()
		else:
			current_card.card_is_dropped()

		is_dragging = false
		current_card = null
