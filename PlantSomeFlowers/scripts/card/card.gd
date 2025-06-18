extends StaticBody3D
class_name Card

@onready var view: MeshInstance3D = $View
@onready var collider: CollisionShape3D = $Collider
@onready var outline: Node = $OutlineHighlighter

var is_dragging: bool = false
var original_pos: Vector3
var drag_offest: Vector3


func _ready() -> void:
	add_to_group("Card")
	hide_outline()


func _process(_delta: float) -> void:
	if is_dragging:
		_dragging()


#region 边缘线高亮
func show_outline():
	outline.show()


func hide_outline():
	outline.hide()


#endregion


#region 捡起、放下、使用
func drag_card():
	print(str(self.name), "被捡起了")
	collider.disabled = true
	is_dragging = true
	pass


func _dragging():
	pass


func drop_card():
	print(str(self.name), "被放下了")
	collider.disabled = false
	is_dragging = false
	pass


func use_card():
	pass
#endregion


# TODO 处理抓取移动的逻辑
