extends StaticBody3D

@onready var view: MeshInstance3D = $View
@onready var collider: CollisionShape3D = $Collider
@onready var outline: Node = $OutlineHighlighter
@onready var used_effect: GPUParticles3D = $UsedEffect

var is_dragging: bool = false
var original_pos: Vector3
var drag_offest: Vector3
@export var focus_offest: Vector3 = Vector3(0, 0.3, -0.1)  # 左右, 上下, 前后

var card_type: CardStats


func _ready() -> void:
	add_to_group("Card")
	_initialize()


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
	var target_pos = position + focus_offest
	create_tween().tween_property(self, "position", target_pos, 0.1)


func mouse_exited_card():
	create_tween().tween_property(self, "position", original_pos, 0.1)
	hide_outline()


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


func card_is_used():
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "rotation", rotation.z + -15, 0.1)
	tween.tween_property(self, "scale", scale * 1.1, 0.1)
	await tween.finished
	
	GlobalSignalBus.card_used.emit(self.card_type)
#endregion

# TODO 处理抓取后移动的逻辑
# TODO 处理粒子发射的效果
