extends Node

## 这里是：游戏控制器
## 负责管理游戏的总处理以及数据的更新

var card
var used_card


func draw_card():
	GameManager.current_holding_card.push_back(card)


func use_card():
	GameManager.current_holding_card.erase(used_card)


func pause_game():
	pass
