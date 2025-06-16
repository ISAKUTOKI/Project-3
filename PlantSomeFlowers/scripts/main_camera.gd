extends Camera3D

@export_group("相机基础属性")
@export var camera_sensitivity: int = 40  # 相机灵敏度
@export var camera_fov: int = 90
@export var camera_far: float = 10
var rotation_speed = camera_sensitivity * 0.00005  # 相机旋转速度
var can_rotate_camera: bool = false

@export_group("相机角度钳制")
@export var camera_angle_limit_x: float = 45  # 上下角度限制(度数)
@export var camera_angle_limit_y: float = 45  # 左右角度限制(度数)

@onready var ray_cast: RayCast3D = $RayCast
@onready var drag_and_drop: Node = $DragAndDrop


func _ready():
	_intialize_camera()


func _intialize_camera():
	self.fov = camera_fov
	self.far = camera_far
	ray_cast.enabled = true


func _input(event):
	if event.is_action_pressed("change_camera_rotatable"):
		can_rotate_camera = !can_rotate_camera
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if can_rotate_camera else Input.MOUSE_MODE_VISIBLE)
	if can_rotate_camera and event is InputEventMouseMotion:
		# 先应用旋转
		_rotate_world_y(event)
		_rotate_local_x(event)
		_clamp_rotation()
		_check_target()

#region 相机的旋转逻辑
# 沿世界y轴左右旋转
func _rotate_world_y(event):
	rotate_y(event.relative.x * -rotation_speed)


# 沿本地x轴上下旋转
func _rotate_local_x(event):
	rotate_object_local(Vector3(1, 0, 0), event.relative.y * -rotation_speed)


# 钳制旋转
func _clamp_rotation():
	var current_rotation_deg = rotation_degrees
	# 钳制X轴旋转
	current_rotation_deg.x = clamp(current_rotation_deg.x, -camera_angle_limit_x, camera_angle_limit_x)
	# 钳制Y轴旋转
	current_rotation_deg.y = clamp(current_rotation_deg.y, -camera_angle_limit_y, camera_angle_limit_y)
	# 限制z轴保证相机稳定
	current_rotation_deg.z = 0
	# 应用钳制后的旋转
	rotation_degrees = current_rotation_deg


#endregion


func _check_target():
	if ray_cast.target:
		if ray_cast.target is Card:
			print("当前目标卡牌是", str(ray_cast.target))
			ray_cast.target._set_mouse_is_on_self_value(true)
		elif ray_cast.target is Flower:
			print("当前目标花是", str(ray_cast.target))
			pass

# TODO 修正当前物体判断的逻辑
# TODO 搭建信号管线进行逻辑处理
