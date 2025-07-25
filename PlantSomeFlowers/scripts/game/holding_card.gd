extends Node3D

var holding_card_object := []
var holding_card_type := []
var hloding_card_name := []
var card: PackedScene = preload("res://scenes/card.tscn")

@export var rank_pos_offset: Vector3 = Vector3(0.4, -0.05, 0)

#region 测试用数据
@export var original_initial_pos: Vector3 = Vector3(0, 0.07, -0.35)
@export var original_initial_rot: Vector3 = Vector3(-40, 0, 0)  # 本地x轴旋转度数
var initial_pos: Vector3 = original_initial_pos
var initial_rot: Vector3 = original_initial_rot
#endregion


func _ready() -> void:
	GlobalSignalBus.start_shake.connect(_on_start_shake)
	GlobalSignalBus.stop_shake.connect(_on_stop_shake)

	GlobalSignalBus.card_drew.connect(_on_draw_card)
	GlobalSignalBus.card_used.connect(_on_use_card)
	_test()


func _test():
	holding_card_object = get_children()
	_rank_holding_card()
	for i in holding_card_object:
		i.original_pos = i.position
		i.original_rot = i.rotation_degrees
		i.original_sca = i.scale
		holding_card_type.push_back(i.card_type)
		hloding_card_name.push_back(CardStats.CARD_NAME[i.card_type])
	#print("当前手牌： ", holding_card_type)
	#print("当前手牌： ", hloding_card_name)


func _on_draw_card(drew_card):
	holding_card_object.push_back(drew_card)
	_rank_holding_card()


func _on_use_card(used_card):
	holding_card_object.erase(used_card)
	_rank_holding_card()


func _rank_holding_card():
	var _x_offset = (holding_card_object.size() - 1) * rank_pos_offset.x * 0.5 * -1
	print("holding_card_object.size:  ",holding_card_object.size())
	#print("_x_offset:  ",_x_offset)
	initial_pos = Vector3(
		original_initial_pos.x + _x_offset, original_initial_pos.y, original_initial_pos.z
	)

	for i in range(holding_card_object.size()):
		var card_node = holding_card_object[i]
		# 计算偏移位置
		var target_pos = (
			initial_pos + Vector3(rank_pos_offset.x * i, rank_pos_offset.y * i, rank_pos_offset.z * i)
		)
		card_node.position = target_pos
		card_node.rotation_degrees = initial_rot


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

# TODO 完成卡牌的抽取逻辑
