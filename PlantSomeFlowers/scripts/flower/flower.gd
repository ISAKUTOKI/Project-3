extends StaticBody3D
class_name Flower

@onready var mesh: MeshInstance3D = $Mesh
@onready var collider: CollisionShape3D = $collider

var flower_type: FlowerStats.FlowerType = FlowerStats.FlowerType.幼苗


func _ready() -> void:
	add_to_group("Flower")
	_initialize()
	GlobalSignalBus.card_used.connect(_on_card_used)


func _initialize():
	pass


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
