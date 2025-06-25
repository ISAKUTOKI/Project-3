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


func _test():
	holding_card = get_children()
	for _card in holding_card:
		_card.position = initial_pos
		_card.rotation_degrees = initial_rot
		#print("card.rotation: ", _card.rotation, "    ", "initial_rot: ", initial_rot)

		_card.original_pos = _card.position
		_card.original_rot = _card.rotation_degrees
		_card.original_sca = _card.scale
		hloding_card_name.push_back(CardStats.CARD_NAME[_card.card_type])
	print(hloding_card_name)


func _initialize():
	holding_card.clear()


func _rank_holding_card():
	for i in holding_card:
		pass
	pass


func draw_card(drew_card):
	GameManager.current_holding_card.push_back(drew_card)


func use_card(used_card):
	GameManager.current_holding_card.erase(used_card)

# TODO 处理排序手牌的逻辑
