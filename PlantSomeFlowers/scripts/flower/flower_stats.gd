extends Node

enum FlowerType {
	默认,
	幼苗,
}

const FLOWER_NAME := {
	FlowerType.默认: "默认",
	FlowerType.幼苗: "幼苗",
}

const FLOWER_MATERIAL:={
	FlowerType.默认: preload("res://materials/flowers/flower_empty.tres"),
	FlowerType.幼苗: preload("res://materials/flowers/flower_empty.tres"),
}
