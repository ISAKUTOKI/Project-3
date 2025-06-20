extends Node

## 这里是：游戏控制器
## 负责管理游戏的总处理以及数据的更新


func shake(strength: GameManager.ShakeType):
	print("进行了一次震动，震幅为： " + GameManager.SHAKE_NAME[strength])
	GlobalSignalBus.start_shake.emit(strength)

func stop_shake():
	GlobalSignalBus.stop_shake.emit()
