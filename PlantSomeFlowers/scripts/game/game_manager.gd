extends Node

## 这里是：游戏管理器
## 负责记录游戏的数据
## 负责管理游戏的状态

var card: PackedScene = preload("res://scenes/card.tscn")

const CARD_SIZE: Vector3 = Vector3(0.5, 0.85, 0.01)  # 宽、高、厚
var current_game_stats: GameStats

enum ShakeType { 小震, 中震, 强震 }
const SHAKE_STRENGTH := {ShakeType.小震: 0.2, ShakeType.中震: 0.4, ShakeType.强震: 0.6}
const SHAKE_NAME := {ShakeType.小震: "小震", ShakeType.中震: "中震", ShakeType.强震: "强震"}

enum GameStats { 游戏中, 暂停 }
