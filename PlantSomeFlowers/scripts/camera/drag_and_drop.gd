extends Node

@onready var camera: Camera3D = $".."
var is_dragging: bool = false
var current_card = null


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_drag_card()
		_drop_card()


#region 核心逻辑
func _drag_card():
	if camera.current_target is Card and Input.is_action_just_pressed("drag"):
		#print("捡起当前卡片")
		current_card = camera.current_target
		current_card.drag_card()
		is_dragging = true


func _drop_card():
	if is_dragging:
		if Input.is_action_just_released("drag") or Input.is_action_just_pressed("drop"):
			if camera.current_target == Flower:
				current_card.use_card()
				GlobalSignalBus.card_used.emit(current_card)
				print("使用")
				return
			#print("放下")
			current_card.drop_card()
			current_card = null
			is_dragging = false
#endregion

# TODO 处理抓取移动的逻辑
