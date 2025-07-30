extends Node


func _ready() -> void:
	GameController.wait_frames(10)
	GameController.test()
