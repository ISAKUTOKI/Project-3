extends Node


func _ready() -> void:
	GameController.wait_frames(10)
	GameController.test()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("test_function_1"):  # ctrl shift F12
		GameController.next_day()
