extends StaticBody3D
class_name Flower

@export var flower_type: FlowerStats.FlowerType = FlowerStats.FlowerType.默认

@onready var view: MeshInstance3D = $View
@onready var collider: CollisionShape3D = $Collider
@onready var outline: Node = $OutlineHighlighter


func _ready() -> void:
	add_to_group("Flower")
	view.mesh.surface_set_material(0, FlowerStats.FLOWER_MATERIAL[flower_type])
	outline.initialize_node()
	_initialize()
	GlobalSignalBus.card_used.connect(_on_card_used)


func _initialize():
	hide_outline()


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
	var card_type=_card.card_type
	match card_type:
		CardStats.CardType.浇水:
			print("使用了一张", CardStats.CARD_NAME[card_type])
		CardStats.CardType.光照:
			print("使用了一张", CardStats.CARD_NAME[card_type])
		CardStats.CardType.修剪:
			print("使用了一张", CardStats.CARD_NAME[card_type])
		CardStats.CardType.捉虫:
			print("使用了一张", CardStats.CARD_NAME[card_type])
		CardStats.CardType.收获:
			print("使用了一张", CardStats.CARD_NAME[card_type])
