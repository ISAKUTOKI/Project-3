extends Node3D

@onready var lamp_holder: Sprite3D = $LampHolder
@onready var lamp_rope: Sprite3D = $LampRope
@onready var lamp: Sprite3D = $LampRope/Lamp

@onready var light_1: Sprite3D = $LampLight1
@onready var light_2: Sprite3D = $LampLight2
@onready var light_3: Sprite3D = $LampLight3
@onready var light_4: Sprite3D = $LampLight4

@onready var animator: AnimationPlayer = $Lamp_animator


func _ready() -> void:
	if animator:
		animator.speed_scale = 0.5
