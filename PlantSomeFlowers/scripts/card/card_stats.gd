extends Node

enum CardType {
	默认,
	浇水,
	光照,
	修剪,
	捉虫,
	收获,
	
	继续,
	设置,
	退出,
}

const CARD_NAME:={
	CardType.默认: "默认<空>",
	CardType.浇水: "浇水",
	CardType.光照: "光照",
	CardType.修剪: "修剪",
	CardType.捉虫: "捉虫",
	CardType.收获: "收获",
	
	CardType.继续: "继续<系统>",
	CardType.设置: "设置<系统>",
	CardType.退出: "收获<系统>",
}

const CARD_MATERIAL:={
	CardType.默认: preload("res://materials/cards/card_empty.tres"),
	CardType.浇水: preload("res://materials/cards/card_water.tres"),
	CardType.光照: preload("res://materials/cards/card_light.tres"),
	CardType.修剪: preload("res://materials/cards/card_trim.tres"),
	CardType.捉虫: preload("res://materials/cards/card_insecticide.tres"),
	CardType.收获: preload("res://materials/cards/card_collect.tres"),
	
	CardType.继续: preload("res://materials/cards/card_continue.tres"),
	CardType.设置: preload("res://materials/cards/card_option.tres"),
	CardType.退出: preload("res://materials/cards/card_exit.tres"),
}
