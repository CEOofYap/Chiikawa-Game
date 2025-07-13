extends Area2D

@onready var game_manager: Node = %"Game Manager"

func _on_body_entered(body: Node2D) -> void:
	game_manager.play_sound(Sound_effect.SOUND_EFFECT_TYPE.collect_key)
	game_manager.add_point()
	queue_free()
