extends Node

## 这里是：游戏管理器
## 负责记录游戏的数据
## 负责管理游戏的状态

var card: PackedScene = preload("res://scenes/card.tscn")

var current_game_stats: GameStats
var current_flower_stats: FlowerStats.FlowerType

var current_stats_used_card := []

const 默认 = CardStats.CardType.默认
const 浇水 = CardStats.CardType.浇水
const 光照 = CardStats.CardType.光照
const 修剪 = CardStats.CardType.修剪
const 捉虫 = CardStats.CardType.捉虫
const 收获 = CardStats.CardType.收获

const CARD_SIZE: Vector3 = Vector3(0.5, 0.85, 0.01)  # 宽、高、厚
enum ShakeType { 小震, 中震, 强震 }
const SHAKE_STRENGTH := {ShakeType.小震: 0.2, ShakeType.中震: 0.4, ShakeType.强震: 0.6}
const SHAKE_NAME := {ShakeType.小震: "小震", ShakeType.中震: "中震", ShakeType.强震: "强震"}

const CURRENT_STATS_HOLDING_CARD := {
	FlowerStats.FlowerType.幼苗: [浇水, 浇水, 浇水, 光照],
	FlowerStats.FlowerType.小枝: [浇水, 浇水, 光照, 光照, 光照, 捉虫],
	FlowerStats.FlowerType.成枝: [浇水, 光照, 修剪, 捉虫],
	FlowerStats.FlowerType.开花: [收获],
	FlowerStats.FlowerType.枯萎: [收获],
	FlowerStats.FlowerType.虫害: [收获],
}

enum GameStats { 正常游戏中, 暂停, 不可操作 }
