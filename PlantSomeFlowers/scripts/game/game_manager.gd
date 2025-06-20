extends Node

## 这里是：游戏管理器
## 负责记录游戏的数据

const CARD_SIZE: Vector3 = Vector3(0.5, 0.85, 0.01)  # 宽、高、厚
var current_holding_card := []

enum ShakeType { small_shake, middle_shake, strong_shake }
const SHAKE_STRENGTH := {
	ShakeType.small_shake: 0.2, 
	ShakeType.middle_shake: 0.4, 
	ShakeType.strong_shake: 0.6
	}
const SHAKE_NAME := {
	ShakeType.small_shake: "轻微震", 
	ShakeType.middle_shake: "中等震", 
	ShakeType.strong_shake: "强震"
}
