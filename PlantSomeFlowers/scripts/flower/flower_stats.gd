extends Node

enum FlowerType {
	默认,
	幼苗,
	小枝,
	成枝,
	开花,
	枯萎,
	虫害,
}

const FLOWER_NAME := {
	FlowerType.默认: "默认<空>",
	FlowerType.幼苗: "幼苗",
	FlowerType.小枝: "小枝",
	FlowerType.成枝: "成枝",
	FlowerType.开花: "开花",
	FlowerType.枯萎: "枯萎",
	FlowerType.虫害: "虫害",
}

const FLOWER_UP_MODEL := {
	FlowerType.成枝: preload("res://models/flower_up_0_model.tres"),
	FlowerType.开花: preload("res://models/flower_up_1_model.tres"),
}

const FLOWER_DOWN_MODEL := {
	FlowerType.默认: null,
	FlowerType.幼苗: preload("res://models/flower_down_1_model.tres"),
	FlowerType.小枝: preload("res://models/flower_down_2_model.tres"),
	FlowerType.成枝: preload("res://models/flower_down_3_model.tres"),
	FlowerType.开花: preload("res://models/flower_down_4_model.tres"),
	FlowerType.枯萎: preload("res://models/flower_down_5_model.tres"),
	FlowerType.虫害: preload("res://models/flower_down_6_model.tres"),
}

const 默认 = CardStats.CardType.默认
const 浇水 = CardStats.CardType.浇水
const 光照 = CardStats.CardType.光照
const 修剪 = CardStats.CardType.修剪
const 捉虫 = CardStats.CardType.捉虫
const 收获 = CardStats.CardType.收获

const NEXT_STATS_NEEDS := {
	FlowerType.默认: [默认],
	FlowerType.幼苗: [浇水, 浇水, 浇水, 光照],
	FlowerType.小枝: [浇水, 浇水, 光照, 光照, 光照, 捉虫],
	FlowerType.成枝: [浇水, 光照, 修剪, 捉虫],
	FlowerType.开花: [收获],
	FlowerType.枯萎: [收获],
	FlowerType.虫害: [收获],
}
