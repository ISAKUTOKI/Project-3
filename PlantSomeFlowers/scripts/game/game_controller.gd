extends Node

## 这里是：游戏控制器
## 负责管理游戏的总处理以及数据的更新


func start_a_shake(strength: GameManager.ShakeType, shake_time: float = 1):
	GlobalSignalBus.start_shake.emit(strength)
	await get_tree().create_timer(shake_time).timeout
	stop_shake()


func stop_shake():
	GlobalSignalBus.stop_shake.emit()


func wait_frames(n: int = 1) -> void:
	for i in n:
		await get_tree().process_frame
