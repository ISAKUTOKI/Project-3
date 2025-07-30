extends Node3D

@onready var lamp_holder: Sprite3D = $LampHolder
var lamp_holder_original_pos: Vector3
@onready var lamp_rope: Sprite3D = $LampHolder/LampRope
@onready var lamp: Sprite3D = $LampHolder/LampRope/Lamp

@onready var light_1: Sprite3D = $LampLight1
@onready var light_2: Sprite3D = $LampLight2
@onready var light_3: Sprite3D = $LampLight3
@onready var light_4: Sprite3D = $LampLight4

@onready var animator: AnimationPlayer = $Lamp_animator


func _ready() -> void:
	lamp_holder_original_pos = lamp_holder.position
	_initialize()
	#GlobalSignalBus.start_shake.connect(_on_start_shake)
	#GlobalSignalBus.stop_shake.connect(_on_stop_shake)


func _initialize():
	lamp_holder.position = lamp_holder_original_pos
	lamp_rope.rotation = Vector3(0, 0, 0)
	lamp.rotation = Vector3(0, 0, 0)
	if animator:
		_play_animation("lamp_light", 0.5)


func _play_animation(clip: String, play_speed_scale: float = 1):
	animator.speed_scale = play_speed_scale
	animator.play(clip)
	pass

#
#func _on_start_shake(shake_type: GameManager.ShakeType):
	#var shake_speed_scale: float
	#match shake_type:
		#GameManager.ShakeType.小震:
			#shake_speed_scale = 1
			#pass
		#GameManager.ShakeType.中震:
			#shake_speed_scale = 1.5
			#pass
		#GameManager.ShakeType.强震:
			#shake_speed_scale = 2
			#pass
	#var lamp_rope_target_rot := Vector3(0, 0, 50)
	#var lamp_target_rot := Vector3(0, 0, 25)
	#var tween = create_tween().set_parallel(true)
	#tween.tween_property(lamp_rope, "rotation_degrees", lamp_rope_target_rot, 2 / shake_speed_scale / 2)
	#tween.tween_property(lamp, "rotation_degrees", lamp_target_rot, 2 / shake_speed_scale / 2)
	#await tween.finished
	#_play_animation("lamp_shake", shake_speed_scale)


#func _on_stop_shake():
	#await get_tree().create_timer(2).timeout
	## 结束动画
	#var tween = create_tween()
	#var tween_2 = create_tween()
	#tween.tween_property(lamp_rope, "rotation_degrees", Vector3(0, 0, 40), 0.5)
	#tween_2.tween_property(lamp, "rotation_degrees", Vector3(0, 0, 20), 0.5)
#
	#tween.tween_property(lamp_rope, "rotation_degrees", Vector3(0, 0, -35), 0.4)
	#tween_2.tween_property(lamp, "rotation_degrees", Vector3(0, 0, -18), 0.4)
#
	#tween.tween_property(lamp_rope, "rotation_degrees", Vector3(0, 0, 30), 0.3)
	#tween_2.tween_property(lamp, "rotation_degrees", Vector3(0, 0, 15), 0.3)
#
	#tween.tween_property(lamp_rope, "rotation_degrees", Vector3(0, 0, -20), 0.2)
	#tween_2.tween_property(lamp, "rotation_degrees", Vector3(0, 0, -11), 0.2)
#
	#tween.tween_property(lamp_rope, "rotation_degrees", Vector3(0, 0, 10), 0.1)
	#tween_2.tween_property(lamp, "rotation_degrees", Vector3(0, 0, 6), 0.1)
#
	#tween.tween_property(lamp_rope, "rotation_degrees", Vector3(0, 0, 0), 0.1)
	#tween_2.tween_property(lamp, "rotation_degrees", Vector3(0, 0, 0), 0.1)
	#await tween.finished
	#await tween_2.finished
	#_initialize()
	#pass
