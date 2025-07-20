#@tool
extends Button

@export var use_this_test: bool = true
@export var shake_strength: GameManager.ShakeType = GameManager.ShakeType.小震
@onready var button_1: Button = $"."
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3

@onready var main_camera: Camera3D = $"../../MainCamera"

@export var use_button_1: bool = true
@export var use_button_2: bool = true
@export var use_button_3: bool = true


func _ready() -> void:
	text = str(GameManager.SHAKE_NAME[shake_strength])
	if button_2:
		button_2.text = "停止震动"
	if button_3:
		button_3.text = "重新排序"

	if not use_button_1:
		button_1.disabled = true
		button_1.visible = false
	if not use_button_2:
		button_2.disabled = true
		button_2.visible = false
	if not use_button_3:
		button_3.disabled = true
		button_3.visible = false


func _on_button_1pressed() -> void:
	if not use_this_test:
		push_warning("未启用此测试功能： " + self.name)
		return
	GameController.start_a_shake(shake_strength, 2.0)


func _on_button_2_pressed() -> void:
	GameController.stop_shake()


func _on_button_3_pressed() -> void:
	var holding_card = $"../../HoldingCard"
	holding_card._rank_holding_card()
