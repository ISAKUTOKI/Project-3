extends StaticBody3D
class_name Flower

@onready var view: MeshInstance3D = $View
@onready var collider: CollisionShape3D = $collider
@onready var outline: Node = $OutlineHighlighter

var flower_type: FlowerStats.FlowerType = FlowerStats.FlowerType.幼苗


func _ready() -> void:
	add_to_group("Flower")
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


func _on_card_used(card: CardStats.CardType):
	match card:
		CardStats.CardType.浇水:
			print("使用了一张", CardStats.CARD_NAME[card])
		CardStats.CardType.光照:
			print("使用了一张", CardStats.CARD_NAME[card])
		CardStats.CardType.修剪:
			print("使用了一张", CardStats.CARD_NAME[card])
		CardStats.CardType.捉虫:
			print("使用了一张", CardStats.CARD_NAME[card])
		CardStats.CardType.收获:
			print("使用了一张", CardStats.CARD_NAME[card])
