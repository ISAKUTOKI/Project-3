extends Node

## 这里是：游戏控制器
## 负责管理游戏的总处理以及数据的更新

@onready var holding_card: Node3D = $"../Node3D/HoldingCard"
@onready var main_camera: Camera3D = $"../Node3D/MainCamera"
@onready var full_black_screen: ColorRect = $"../Node3D/FullBlackScreen"


func test():
	_initialize_new_stats(FlowerStats.FlowerType.幼苗)


func start_a_shake(strength: GameManager.ShakeType, shake_time: float = 1):
	GlobalSignalBus.start_shake.emit(strength)
	await get_tree().create_timer(shake_time).timeout
	stop_shake()


func stop_shake():
	GlobalSignalBus.stop_shake.emit()


func wait_frames(time: int = 1) -> void:
	for i in time:
		await get_tree().process_frame


func drow_card(_card_type: CardStats.CardType):
	var target_card = GameManager.card.instantiate()
	target_card.card_type = _card_type
	GlobalSignalBus.card_drew.emit(target_card)


func use_card(_card: Card):
	GlobalSignalBus.card_used.emit(_card)
	GameManager.current_stats_used_card.push_back(_card.card_type)


func next_day():
	GameManager.current_remaining_day -= 1
	if GameManager.current_remaining_day < 0:
		print(self.name, "时间差不多咯~")
		return
	# 动画
	var color_alpha_1 = Color(
		full_black_screen.color.r, full_black_screen.color.g, full_black_screen.color.b, 1
	)
	var color_alpha_0 = Color(
		full_black_screen.color.r, full_black_screen.color.g, full_black_screen.color.b, 0
	)
	var tween: Tween = create_tween()
	set_camera_enable(false)
	tween.tween_property(full_black_screen, "color", color_alpha_1, 0.7)
	# 清除当前手牌并检查当前阶段
	tween.tween_callback(func(): holding_card.clear_holding_card())
	tween.tween_callback(func(): _check_current_stats_used_card())
	# 黑屏
	tween.tween_interval(0.7)
	# 动画
	tween.tween_property(main_camera, "rotation_degrees", Vector3(0, 0, 0), 0.01)
	tween.tween_property(full_black_screen, "color", color_alpha_0, 0.7)
	await tween.finished
	set_camera_enable(true)


func set_camera_enable(_can_process: bool):
	main_camera.set_process_input(_can_process)
	main_camera.raycast.enabled = _can_process
	main_camera.drag_and_drop.set_process_input(_can_process)

func _init() -> void:
	pass

func generate_card(card_type,_position:Vector3):
	if card_type is CardStats.CardType or card_type is FlowerStats.FlowerType:
		pass
	else:
		pass
	pass
#region 和花朵有关的逻辑
func _check_current_stats_used_card():
	var _flower_type = GameManager.current_flower_stats
	var _current_array = GameManager.current_stats_used_card
# 检查当前状态，如果是不可继续的状态则不进行检查，等待收获
	match _flower_type:
		FlowerStats.FlowerType.开花:
			return
		FlowerStats.FlowerType.枯萎:
			return
		FlowerStats.FlowerType.虫害:
			return
# 进行检查
	var _target_array = FlowerStats.NEXT_STATS_NEEDS[_flower_type]
	if not _multiset_equal(_current_array, _target_array):
		_reset_current_stats()
		return
	var _next_stats = _flower_type + 1
	_initialize_new_stats(_next_stats)


func _multiset_equal(a: Array, b: Array) -> bool:
	if a.size() != b.size():
		return false
	var count_map_a := {}
	var count_map_b := {}
	for item in a:
		count_map_a[item] = count_map_a.get(item, 0) + 1
	for item in b:
		count_map_b[item] = count_map_b.get(item, 0) + 1
	return count_map_a == count_map_b


func _initialize_new_stats(_flower_type: FlowerStats.FlowerType):
	GameManager.current_stats_used_card.clear()
	GameManager.current_remaining_day = GameManager.CURRENT_STATS_TOTAL_DAY[_flower_type]
	GameManager.current_flower_stats = _flower_type
	GlobalSignalBus.flower_update_stats.emit(_flower_type)
	_reset_current_stats()
	#print(self.name, "发射了信号")


func _reset_current_stats():
	holding_card.clear_holding_card()
	_drow_current_stats_holding_card()


func _drow_current_stats_holding_card(
	_current_stats: FlowerStats.FlowerType = FlowerStats.FlowerType.默认
):
	if _current_stats == FlowerStats.FlowerType.默认:
		_current_stats = GameManager.current_flower_stats
	#print(self.name,GameManager.CURRENT_STATS_HOLDING_CARD[_current_stats])
	for i in GameManager.CURRENT_STATS_HOLDING_CARD[_current_stats]:
		drow_card(i)

#endregion
# TODO 完成开头画面
# TODO 完成故事线
# TODO 完成控制选项的卡牌
# TODO 完成掉落卡牌的逻辑（抛物线）
