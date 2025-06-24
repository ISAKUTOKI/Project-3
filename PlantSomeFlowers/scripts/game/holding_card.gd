extends Node3D


func _test():
	holding_card = get_children()
	for i in holding_card:
		i.original_pos = i.position
		i.original_rot = i.rotation
		i.original_sca = i.scale
		hloding_card_name.push_back(CardStats.CARD_NAME[i.card_type])
	print(hloding_card_name)


var holding_card := []
var hloding_card_name := []
var card: PackedScene = preload("res://scenes/card.tscn")

@export var offset: Vector3 = Vector3(0.4, 0, 0.8)  # x, y, z
@export var initial_pos: Vector3 = Vector3(0, 0.07, -0.35)  # x, y, z
@export var initial_rot: float = -40.0  # 本地x轴旋转度数


func _ready() -> void:
	_initialize()
	_test()


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
