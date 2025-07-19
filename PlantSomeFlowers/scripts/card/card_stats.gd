extends Node

enum CardType {
	默认,
	浇水,
	光照,
	修剪,
	捉虫,
	收获,
}

const CARD_NAME:={
	CardType.默认: "默认<空>",
	CardType.浇水: "浇水",
	CardType.光照: "光照",
	CardType.修剪: "修剪",
	CardType.捉虫: "捉虫",
	CardType.收获: "收获",
}

const CARD_MATERIAL:={
	CardType.默认: preload("res://materials/cards/card_empty.tres"),
	#CardType.浇水: preload(),
	#CardType.光照: preload(),
	#CardType.修剪: preload(),
	#CardType.捉虫: preload(),
	CardType.收获: preload("res://materials/cards/card_collect.tres"),
}
