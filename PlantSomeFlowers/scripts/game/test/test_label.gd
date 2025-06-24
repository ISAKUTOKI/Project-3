extends Label

@export var use_this_test: bool = true
@export var camera: Camera3D
var card_pos: Vector3
var card_rot: Vector3


func _process(_delta: float) -> void:
	if not use_this_test:
		_waring()
		return
	if camera == null:
		camera = get_node("MainCamera")
		if camera == null:
			camera = $"../../MainCamera"
			if camera == null:
				push_warning("当前场景树中没有主相机，请手动拖拽赋值")
	if camera.current_target == null:
		text = "--当前没有目标--"
		return
	card_pos = camera.current_target.position
	card_rot = camera.current_target.rotation

	if camera.current_target is Card:
		self.text = CardStats.CARD_NAME[camera.current_target.card_type]
	elif camera.current_target is Flower:
		self.text = FlowerStats.FLOWER_NAME[camera.current_target.flower_type]
	self.text += "        "  # 8
	self.text += "位置：" + str(card_pos)
	self.text += "        "  # 8
	self.text += "旋转：" + str(card_rot)


var has_warned: bool = false


func _waring():
	if has_warned:
		return
	push_warning("未启用此测试功能： " + self.name)
	has_warned = true
