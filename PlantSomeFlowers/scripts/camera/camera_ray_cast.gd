extends RayCast3D
## 在此脚本只处理射线的运作逻辑，并记录当前具有collider的对象

# 射线检测距离
var ray_length = 1000.0
@onready var camera: Camera3D = $".."


func _input(event):
	if event is InputEventMouseMotion:
		_update_raycast()
		_get_collider()


func _update_raycast():
	# 更新射线方向（从摄像机发射到鼠标位置）
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * ray_length
	target_position = to_local(ray_end)


var target = null


func _get_collider():
	if is_colliding():
		target = get_collider() # 返回第一个与射线相交的Object
		#print("选中物体：", target.name)
		if camera.has_method("_on_raycast_target_changed"):
			camera._on_raycast_target_changed(target)
	else:
		if target != null:
			if camera.has_method("_on_raycast_target_changed"):
				camera._on_raycast_target_changed(null)
		target = null
		#print(str(target))
