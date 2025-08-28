extends Node

@export var is_in_test: bool = false
@onready var alt_icon: Sprite3D = $AltIcon
@onready var alt_icon_anime: AnimationPlayer = $AltIcon/AltIconAnimationPlayer

var tutorial_is_done: bool = false


func _ready() -> void:
	alt_icon.visible = false
	if not is_in_test:
		pass
	else:
		GameController.load_game()
		GameController.wait_frames(10)
		GameController._initialize_new_stats(FlowerStats.FlowerType.教程1)
	await get_tree().create_timer(0.7).timeout
	if tutorial_is_done:
		return
	else:
		_show_tutorial()


func _show_tutorial():
	alt_icon.modulate=Color(1,1,1,0)
	alt_icon.visible = true
	GameController.wait_frames(5)
	alt_icon_anime.play("alt_icon")


func _input(_event: InputEvent) -> void:
	if not is_in_test:
		return

	if Input.is_action_just_pressed("test_function_1"):  # ctrl shift F12
		GameController.next_day()

	if tutorial_is_done:
		return
	else:
		if Input.is_action_just_pressed("change_camera_rotatable"):  # alt
			alt_icon.visible = false
			tutorial_is_done = true
