extends StaticBody3D
class_name Card

@onready var view: MeshInstance3D = $View
@onready var collider: CollisionShape3D = $Collider
@onready var outline: Node = $OutlineHighlighter
var mouse_is_on_self: bool = false


func _ready() -> void:
	hide_outline()


func _process(_delta: float) -> void:
	_set_mouse_is_on_self_value()


func _physics_process(delta: float) -> void:
	_dragging(delta)


func show_outline():
	outline.show()

func hide_outline():
	outline.hide()

func _set_mouse_is_on_self_value(value: bool = false):
	mouse_is_on_self = value


#region 捡起与放下以及使用相关的逻辑
func drag_card():
	print(str(self.name), "被捡起来了")
	collider.disabled = true
	pass


func _dragging(_delta):
	pass


func drop_card():
	print(str(self.name), "被放下了")
	collider.disabled = false


func use_card():
	pass
#endregion

# TODO 处理抓起与放下的逻辑
