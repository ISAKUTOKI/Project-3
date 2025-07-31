extends StaticBody3D
class_name Card

@export var card_type: CardStats.CardType = CardStats.CardType.默认

@onready var view: MeshInstance3D = $View
@onready var collider: CollisionShape3D = $Collider
@onready var outline: Node = $OutlineHighlighter
@onready var used_effect: GPUParticles3D = $UsedEffect

var material: StandardMaterial3D = null

var is_dragging: bool = false
var original_pos: Vector3
var original_rot: Vector3
var original_sca: Vector3
var drag_offest: Vector3
var focus_offest: Vector3 = Vector3(0, 0.2, -0.1)  # 鼠标悬停时的偏移


func _ready() -> void:
	add_to_group("Card")
	_initialize()


func _initialize():
	material = CardStats.CARD_MATERIAL[card_type]
	view.mesh.surface_set_material(0, material)
	outline.initialize_node()


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
	#print(str(self.name), "被捡起了")
	hide_outline()
	collider.disabled = true
	is_dragging = true


func card_is_dropped():
	#print(str(self.name), "被放下了")
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "position", original_pos, 0.1)
	tween.tween_property(self, "rotation_degrees", original_rot, 0.1)
	tween.tween_property(self, "scale", original_sca, 0.1)
	await tween.finished
	collider.disabled = false
	is_dragging = false


func card_is_used():
	#print(str(self.name), "用掉了")
	# 卡牌动画
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "rotation", Vector3(rotation.x, rotation.y, rotation.z + -0.1), 0.1)
	tween.tween_property(self, "scale", scale * 1.1, 0.1)
	await tween.finished

	# 粒子特效
	used_effect.emitting = true
	await get_tree().create_timer(used_effect.lifetime + 0.1).timeout

	# 数据
	GameController.use_card(self)
	# 视觉
	var tween2 = create_tween()
	tween2.tween_property(self, "scale", Vector3(0.001, 0.001, 0.001), 0.1)
	await tween2.finished
	view.visible = false
	GameController.wait_frames(2)
	self.queue_free()
	#card_is_dropped()
#endregion
