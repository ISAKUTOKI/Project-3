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
	FlowerType.默认: "默认",
	FlowerType.幼苗: "幼苗",
	FlowerType.小枝: "小枝",
	FlowerType.成枝: "成枝",
	FlowerType.开花: "开花",
	FlowerType.枯萎: "枯萎",
	FlowerType.虫害: "虫害",
}

const FLOWER_UP_MODEL := {
	FlowerType.开花: preload("res://models/flower_up_1_model.tres"),
	FlowerType.枯萎: preload("res://models/flower_up_1_model.tres"),  # 占位
}

const FLOWER_DOWN_MODEL := {
	FlowerType.默认: preload("res://models/flower_down_1_model.tres"),  # 占位
	FlowerType.幼苗: preload("res://models/flower_down_1_model.tres"),
	FlowerType.小枝: preload("res://models/flower_down_2_model.tres"),
	FlowerType.成枝: preload("res://models/flower_down_3_model.tres"),
	FlowerType.开花: preload("res://models/flower_down_4_model.tres"),
	FlowerType.枯萎: preload("res://models/flower_down_5_model.tres"),
	FlowerType.虫害: preload("res://models/flower_down_6_model.tres"),
}
