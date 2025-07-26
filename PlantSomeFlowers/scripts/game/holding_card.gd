extends Node3D

var holding_card_object := []
var holding_card_type := []
var holding_card_name := []

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
	GameController.drow_card(CardStats.CardType.浇水)
	GameController.drow_card(CardStats.CardType.浇水)
	GameController.drow_card(CardStats.CardType.光照)
	GameController.drow_card(CardStats.CardType.浇水)
	GameController.drow_card(CardStats.CardType.修剪)
	#print("当前手牌： ", holding_card_type)
	#print("当前手牌： ", hloding_card_name)


func _on_draw_card(drew_card: Card):
	add_child(drew_card)
	holding_card_object.push_back(drew_card)
	holding_card_type.push_back(drew_card.card_type)
	holding_card_name.push_back(CardStats.CARD_NAME[drew_card.card_type])
	_rank_holding_card()


func _on_use_card(used_card: Card):
	holding_card_object.erase(used_card)
	holding_card_type.erase(used_card.card_type)
	holding_card_name.erase(CardStats.CARD_NAME[used_card.card_type])
	_rank_holding_card()


func _rank_holding_card():
	var _x_offset = (holding_card_object.size() - 1) * rank_pos_offset.x * 0.5 * -1
	#print("holding_card_object.size:  ", holding_card_object.size())
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
		# 赋值
		card_node.position = target_pos
		card_node.rotation_degrees = initial_rot
		# 记录
		card_node.original_pos = card_node.position
		card_node.original_rot = card_node.rotation_degrees
		card_node.original_sca = card_node.scale
	#_print_current_holding_card_info()


func _print_current_holding_card_info():
	print("card_type: ", holding_card_type)
	print("card_name: ", holding_card_name)
	print("__________")


func clear_holding_card():
	if holding_card_object.size() == 0:
		print("没有手牌了")
		return
	#print(self.name,"  -test-")
	for i in holding_card_object:
			i.queue_free()
	GameController.wait_frames()
	holding_card_object.clear()
	holding_card_type.clear()
	holding_card_name.clear()
	#_print_current_holding_card_info()
	_rank_holding_card()


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
