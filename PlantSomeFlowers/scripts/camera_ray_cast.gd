extends RayCast3D

# 射线检测距离
var ray_length = 1000.0
@onready var camera: Camera3D = $".."


func _input(event):
	if event is InputEventMouseMotion:
		_update_ray_check()
		_get_collider()


func _update_ray_check():
	# 更新射线方向（从摄像机发射到鼠标位置）
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * ray_length
	target_position = to_local(ray_end)


var target = null


func _get_collider():
	#print("无碰撞")
	if is_colliding():
		target = get_collider()
		#var target_point = get_collision_point()
		#var target_normal = get_collision_normal()
		#print("选中物体：", target.name)
		#print("碰撞点：", target_point)
		#print("法线方向：", target_normal)
	else:
		target = null
		#print(str(target))
