#@tool
extends Button

@export var use_this_test: bool = true
@export var shake_strength: GameManager.ShakeType = GameManager.ShakeType.小震
@export var card_type: CardStats.CardType = CardStats.CardType.默认

@onready var button_1: Button = $"."
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3

@onready var main_camera: Camera3D = $"../../MainCamera"

@export var use_button_1: bool = true
@export var use_button_2: bool = true
@export var use_button_3: bool = true


func _ready() -> void:
	self.text = str("可用")
	if button_2:
		button_2.text = "不可用"
	if button_3:
		button_3.text = "下一天"

	if not use_button_1:
		button_1.disabled = true
		button_1.visible = false
	if not use_button_2:
		button_2.disabled = true
		button_2.visible = false
	if not use_button_3:
		button_3.disabled = true
		button_3.visible = false


@onready var holding_card: Node3D = $"../../HoldingCard"


func _on_button_1_pressed() -> void:
	GameController.set_camera_enable(true)


func _on_button_2_pressed() -> void:
	GameController.set_camera_enable(false)


func _on_button_3_pressed() -> void:
	GameController.next_day()
