extends Node

## 这里是：游戏管理器
## 负责记录游戏的数据
## 负责管理游戏的状态
enum GameStats { 正常游戏中, 暂停, 不可操作, 主界面 }
enum ShakeType { 小震, 中震, 强震 }

var current_game_stats: GameStats
var current_flower_stats: FlowerStats.FlowerType
var current_stats_used_card := []
var current_remaining_day: int = 0
var current_harvest_flowers := []

const 默认 = CardStats.CardType.默认
const 浇水 = CardStats.CardType.浇水
const 光照 = CardStats.CardType.光照
const 修剪 = CardStats.CardType.修剪
const 捉虫 = CardStats.CardType.捉虫
const 收获 = CardStats.CardType.收获
const 下一天 = CardStats.CardType.继续
const 需求 = CardStats.CardType.设置
const 退出 = CardStats.CardType.退出

const card: PackedScene = preload("res://scenes/card.tscn")
const CARD_SIZE: Vector3 = Vector3(0.5, 0.85, 0.01)  # 宽、高、厚
const SHAKE_STRENGTH := {ShakeType.小震: 0.2, ShakeType.中震: 0.4, ShakeType.强震: 0.6}
const SHAKE_NAME := {ShakeType.小震: "小震", ShakeType.中震: "中震", ShakeType.强震: "强震"}

const CURRENT_STATS_HOLDING_CARD := {
	FlowerStats.FlowerType.教程1: [下一天],
	FlowerStats.FlowerType.教程2: [下一天, 需求],
	FlowerStats.FlowerType.幼苗: [浇水, 光照, 收获, 下一天, 需求, 退出],
	FlowerStats.FlowerType.小枝: [浇水, 光照, 捉虫, 收获, 下一天, 需求, 退出],
	FlowerStats.FlowerType.成枝: [浇水, 光照, 修剪, 捉虫, 收获, 下一天, 需求, 退出],
	FlowerStats.FlowerType.开花: [收获, 退出],
	FlowerStats.FlowerType.枯萎: [收获, 退出],
	FlowerStats.FlowerType.虫害: [收获, 退出],
}
const CURRENT_STATS_TOTAL_DAY := {
	FlowerStats.FlowerType.教程1: 99,
	FlowerStats.FlowerType.教程2: 99,
	FlowerStats.FlowerType.幼苗: 4,
	FlowerStats.FlowerType.小枝: 4,
	FlowerStats.FlowerType.成枝: 2,
	FlowerStats.FlowerType.开花: 99,
	FlowerStats.FlowerType.枯萎: 99,
	FlowerStats.FlowerType.虫害: 99,
}

const CURSOR_ICON = preload("res://assets/images/cursor_icon.png")
const CURSOR_SCENE = preload("res://scenes/cursor.tscn")
const ALT_ICON = preload("res://assets/images/alt_icon.png")
