extends Label

@export var use_this_test: bool = true
@export var camera: Camera3D
var card_pos: Vector3
var card_rot: Vector3

func _ready() -> void:
	if not use_this_test:
		self.visible=false

func _process(_delta: float) -> void:
	if not use_this_test:
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
	else:
		text = "--当前目标为： "
	if camera.current_target is Card:
		self.text += CardStats.CARD_NAME[camera.current_target.card_type]
	elif camera.current_target is Flower:
		self.text += FlowerStats.FLOWER_NAME[camera.current_target.flower_type]
	self.text += "--        "  # 8
	self.text += "位置：" + str(camera.current_target.position)
	self.text += "        "  # 8
	self.text += "旋转：" + str(camera.current_target.rotation)
	self.text += "        "  # 8
	self.text += "当前剩余天数："+str( GameManager.current_remaining_day)


var has_warned: bool = false
