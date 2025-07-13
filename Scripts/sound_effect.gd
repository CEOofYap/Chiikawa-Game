extends Resource
class_name Sound_effect

enum SOUND_EFFECT_TYPE {
	walk1,
	walk2,
	collect_key,
	fireball_explode
}

@export_range(0, 10) var limit: int = 5
@export var type: SOUND_EFFECT_TYPE
@export var sound_effect: AudioStream
@export_range(-40, 20) var volume: float = 0
@export_range(0.0, 4.0,.01) var pitch_scale: float = 1.0
@export_range(0.0, 1.0,.01) var pitch_randomness: float = 0.0

var audio_count : int = 0

func change_audio_count(amount: int) -> void:
	audio_count = max(0, audio_count + amount)

func has_open_limit() -> bool:
	return audio_count < limit

func on_audio_finished() -> void:
	change_audio_count(-1)
