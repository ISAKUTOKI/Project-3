extends Node


func _test():
	holding_card = get_children()
	for i in holding_card:
		i.original_pos = i.position
		i.original_rot = i.rotation
	print(holding_card)


var holding_card := []

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


func draw_card(card):
	GameManager.current_holding_card.push_back(card)


func use_card(used_card):
	GameManager.current_holding_card.erase(used_card)

# TODO 处理排序的逻辑
