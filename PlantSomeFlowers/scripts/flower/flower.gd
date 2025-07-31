extends StaticBody3D
class_name Flower

@export var flower_type: FlowerStats.FlowerType = FlowerStats.FlowerType.幼苗

@onready var flower_pot: MeshInstance3D = $View
@onready var flower_up: MeshInstance3D = $View/FlowerUp
@onready var flower_down: MeshInstance3D = $View/FlowerDown

@onready var collider: CollisionShape3D = $Collider
@onready var outline: Node = $OutlineHighlighter


func _ready() -> void:
	add_to_group("Flower")
	outline.initialize_node()
	_initialize()

	GlobalSignalBus.card_used.connect(_on_card_used)
	GlobalSignalBus.flower_update_stats.connect(_on_flower_update_stats)


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
	match _card:
		CardStats.CardType.收获:
			_harvest()
		CardStats.CardType.继续:
			GameController.drow_card(CardStats.CardType.继续)
		CardStats.CardType.设置:
			GameController.drow_card(CardStats.CardType.设置)
		CardStats.CardType.退出:
			GameController.drow_card(CardStats.CardType.退出)


func _on_flower_update_stats(_flower_type: FlowerStats.FlowerType):
	if _flower_type == FlowerStats.FlowerType.成枝 or _flower_type == FlowerStats.FlowerType.开花:
		flower_up.mesh = FlowerStats.FLOWER_UP_MODEL[_flower_type]
	else:
		flower_up.mesh = null
	flower_down.mesh = FlowerStats.FLOWER_DOWN_MODEL[_flower_type]
	#print(self.name,"执行无误")


func _harvest():
	pass


func die_away():
	pass
