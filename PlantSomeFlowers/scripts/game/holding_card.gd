extends Node3D

var holding_card := []
var hloding_card_name := []
var card: PackedScene = preload("res://scenes/card.tscn")

@export var rank_offset: Vector3 = Vector3(0.4, 0, 0.8)  # x, y, z

@export var initial_pos: Vector3 = Vector3(0, 0.07, -0.35)  # x, y, z
@export var initial_rot: Vector3 = Vector3(-40, 0, 0)  # 本地x轴旋转度数


func _ready() -> void:
	_initialize()
	_test()
	GlobalSignalBus.start_shake.connect(_on_start_shake)
	GlobalSignalBus.stop_shake.connect(_on_stop_shake)


func _test():
	holding_card = get_children()
	for i in holding_card:
		i.position = initial_pos
		i.rotation_degrees = initial_rot
		#print("card.rotation: ", i.rotation, "    ", "initial_rot: ", initial_rot)

		i.original_pos = i.position
		i.original_rot = i.rotation_degrees
		i.original_sca = i.scale
		hloding_card_name.push_back(CardStats.CARD_NAME[i.card_type])
	print(hloding_card_name)


func _initialize():
	holding_card.clear()
	original_pos = position


func draw_card(drew_card):
	GameManager.current_holding_card.push_back(drew_card)


func use_card(used_card):
	GameManager.current_holding_card.erase(used_card)


func _rank_holding_card():
	for i in holding_card:
		pass


# TODO 处理排序手牌的逻辑

#region 震动时隐藏手牌
var original_pos: Vector3


func _on_start_shake(_shake_type: GameManager.ShakeType):
	var tween = create_tween()
	tween.tween_property(self, "position", original_pos + Vector3(0, -2, 0), 0.1)
	pass


func _on_stop_shake():
	var tween = create_tween()
	tween.tween_property(self, "position", original_pos, 0.1)
	pass
#endregion
