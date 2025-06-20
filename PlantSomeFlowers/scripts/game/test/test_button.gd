extends Button

@export var use_this_test: bool = true
@export var shake_strength: GameManager.ShakeType = GameManager.ShakeType.small_shake

@onready var button2: Button = $StopButton


func _ready() -> void:
	text = str(GameManager.SHAKE_NAME[shake_strength])
	if button2:
		button2.text = "停止震动"


func _on_pressed() -> void:
	#print("按下了： " + self.name)
	if not use_this_test:
		push_warning("未启用此测试功能： " + self.name)
		return
	GameController.shake(shake_strength)


func _on_stop_button_pressed() -> void:
	GameController.stop_shake()
