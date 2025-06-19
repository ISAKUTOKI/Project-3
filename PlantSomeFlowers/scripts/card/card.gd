extends StaticBody3D

@onready var view: MeshInstance3D = $View
@onready var collider: CollisionShape3D = $Collider
@onready var outline: Node = $OutlineHighlighter

var is_dragging: bool = false
var original_pos: Vector3
var drag_offest: Vector3
@export var focus_offest: Vector3 = Vector3(0, 0.2, -0.07)  # x, y, z

var card_type: CardStats


func _ready() -> void:
	add_to_group("Card")
	_initialize()


func _process(_delta: float) -> void:
	if is_dragging:
		_dragging()


func _initialize():
	hide_outline()


#region 边缘线高亮
func show_outline():
	outline.show()


func hide_outline():
	outline.hide()


#endregion


#region 鼠标悬停、捡起、放下、使用
func mouse_entered_card():
	show_outline()
	position += focus_offest


func mouse_exited_card():
	hide_outline()
	position = original_pos


func card_is_dragged():
	print(str(self.name), "被捡起了")
	hide_outline()
	collider.disabled = true
	is_dragging = true
	pass


func card_is_dropped():
	print(str(self.name), "被放下了")
	position = original_pos
	collider.disabled = false
	is_dragging = false
	pass


func _dragging():
	pass


func card_is_used():
	pass
#endregion

# TODO 处理抓取后移动的逻辑
