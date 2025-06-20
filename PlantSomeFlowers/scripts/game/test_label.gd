extends Label

@export var camera: Camera3D

var card_pos: Vector3
var card_rot: Vector3


func _process(delta: float) -> void:
	if camera.current_target==null:return
	card_pos = camera.current_target.position
	card_rot = camera.current_target.rotation
	self.text = "位置： " + str(card_pos)
	self.text += "旋转： " + str(card_rot)
