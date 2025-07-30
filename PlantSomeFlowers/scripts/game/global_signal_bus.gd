extends Node

@warning_ignore("unused_signal")
signal card_used(card: Card)
@warning_ignore("unused_signal")
signal card_drew(card: Card)

@warning_ignore("unused_signal")
signal start_shake(shake_type: GameManager.ShakeType)
@warning_ignore("unused_signal")
signal stop_shake

@warning_ignore("unused_signal")
signal flower_update_stats(flower_type: FlowerStats.FlowerType)
