extends StaticBody3D
class_name Flower

@export var flower_type: FlowerStats.FlowerType = FlowerStats.FlowerType.幼苗

@onready var flower_pot: MeshInstance3D = $View
@onready var flower_up: MeshInstance3D = $View/FlowerUp
@onready var flower_down: MeshInstance3D = $View/FlowerDown

@onready var collider: CollisionShape3D = $Collider
@onready var outline: Node = $OutlineHighlighter

@onready var chat_box: AnimatedSprite3D = $ChatBox
@onready var require_icon: Sprite3D = $ChatBox/RequireIcon
@onready var harvest_effect: GPUParticles3D = $HarvestEffect


func _ready() -> void:
	add_to_group("Flower")
	outline.initialize_node()
	_initialize()

	GlobalSignalBus.card_used.connect(_on_card_used)
	GlobalSignalBus.flower_update_stats.connect(_on_flower_update_stats)
	GlobalSignalBus.show_require.connect(_on_show_require)
	GlobalSignalBus.hide_require.connect(_on_hide_require)


func _initialize():
	hide_outline()
	hide_require()
	self.scale = Vector3(1, 1, 1)
	self.visible = true


#region 边缘线高亮
func show_outline():
	outline.show()


func hide_outline():
	outline.hide()


#endregion


#region 鼠标状态切换
func mouse_entered_card():
	show_outline()


func mouse_exited_card():
	hide_outline()


#endregion


func _on_card_used(_card: Card):
	match _card.card_type:
		CardStats.CardType.收获:
			_harvest()
		CardStats.CardType.继续:
			GameController.next_day()
		CardStats.CardType.设置:
			GameController.check_requirements()
		CardStats.CardType.退出:
			GameController.exit_game()


func _on_flower_update_stats(_flower_type: FlowerStats.FlowerType):
	if _flower_type == FlowerStats.FlowerType.成枝 or _flower_type == FlowerStats.FlowerType.开花:
		flower_up.mesh = FlowerStats.FLOWER_UP_MODEL[_flower_type]
	else:
		flower_up.mesh = null
	_initialize()
	flower_down.mesh = FlowerStats.FLOWER_DOWN_MODEL[_flower_type]
	#print(self.name,"执行无误")


func _harvest():
	GameController.clear_holding_cards()
	GameController.set_camera_enable(false)
	GameManager.current_harvest_flowers.push_back(flower_type)
	harvest_effect.emitting = true
	await get_tree().create_timer(0.5).timeout
	var tween = create_tween()
	tween.tween_property(self, "scale", scale * 1.3, 0.1)
	tween.tween_property(self, "scale", scale * 0.01, 0.2)
	await tween.finished
	self.visible = false
	await get_tree().create_timer(0.5).timeout  # 等待时间
	GameController.black_screen()
	await get_tree().create_timer(0.7).timeout  # 黑屏时间
	GameController._initialize_new_stats(FlowerStats.FlowerType.幼苗)
	GameController.set_camera_enable(true)
	await get_tree().create_timer(0.7).timeout  # 白屏时间
	GameController.white_screen()
	#print(self.name,GameManager.current_harvest_flowers)


func die_away():
	pass


func _on_show_require(
	_show_time: float = 2.0,
	_target_icon: CardStats.CardType = CardStats.CardType.默认,
):
	chat_box.play()
	if (
		_target_icon == CardStats.CardType.默认
		or _target_icon == CardStats.CardType.继续
		or _target_icon == CardStats.CardType.设置
		or _target_icon == CardStats.CardType.退出
	):
		require_icon.texture = null
	else:
		require_icon.texture = FlowerStats.FLOWER_REQUIRE_ICON[_target_icon]

	chat_box.visible = true
	require_icon.visible = true

	await get_tree().create_timer(_show_time).timeout
	hide_require()


func _on_hide_require():
	hide_require()


func hide_require():
	chat_box.visible = false
	require_icon.visible = false
	chat_box.pause()
	pass
