extends Camera3D

@export var sensitivity: int = 50  # 鼠标灵敏度
var rotation_speed = sensitivity * 0.00005  # 鼠标速度
var can_rotate_camera: bool = false
var viewport_size: Vector2

@export var camera_shake_strength: float = 10  # 镜头晃动强度
var can_shake_camera: bool = true


func _ready():
	viewport_size = get_viewport().size
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_size_changed"))

	_intialize_camera()


func _process(_delta: float) -> void:
	_shake_camera()


func _intialize_camera():
	self.fov = 90
	self.far = 10


# 当窗口大小变化时
func _on_viewport_size_changed():
	viewport_size = get_viewport().size


func _input(event):
	# 切换鼠标可见性和摄像机旋转状态
	if event.is_action_pressed("change_mouse_visiable"):
		can_rotate_camera = !can_rotate_camera
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if can_rotate_camera else Input.MOUSE_MODE_VISIBLE)

	# 只在可以旋转摄像机时处理鼠标移动
	if can_rotate_camera and event is InputEventMouseMotion:
		# 旋转摄像机
		rotate_y(event.relative.x * -rotation_speed)
		rotate_object_local(Vector3(1, 0, 0), event.relative.y * -rotation_speed)

		# 检查鼠标是否接近窗口边缘
		var mouse_pos = get_viewport().get_mouse_position()
		var edge_threshold = 50  # 离边缘50像素时重置鼠标位置

		# 是否需要重置鼠标位置
		var need_warp = false
		var new_mouse_pos = mouse_pos

		# 检查各边缘
		if mouse_pos.x <= edge_threshold:
			new_mouse_pos.x = viewport_size.x - edge_threshold - 10
			need_warp = true
		elif mouse_pos.x >= viewport_size.x - edge_threshold:
			new_mouse_pos.x = edge_threshold + 10
			need_warp = true

		if mouse_pos.y <= edge_threshold:
			new_mouse_pos.y = viewport_size.y - edge_threshold - 10
			need_warp = true
		elif mouse_pos.y >= viewport_size.y - edge_threshold:
			new_mouse_pos.y = edge_threshold + 10
			need_warp = true

		# 如果需要重置鼠标位置
		if need_warp:
			get_viewport().warp_mouse(new_mouse_pos)


func _shake_camera():
	if can_shake_camera:
		print("当前可以摇晃摄像头")
	else:
		print("不准晃")

# TODO 做个镜头自然晃动效果，当正在移动摄像头的时候不进行摇晃，当静置1秒后进行摇晃，不考虑时候可以旋转摄像头
