extends Node2D

var sound_effect_dict: Dictionary = {}

@export var sound_effects: Array[Sound_effect]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for sound_effect: Sound_effect in sound_effects:
		sound_effect_dict[sound_effect.type] = sound_effect

func create_audio(type: Sound_effect.SOUND_EFFECT_TYPE) -> void:
	if sound_effect_dict.has(type):
		var sound_effect: Sound_effect = sound_effect_dict[type]
		if sound_effect.has_open_limit():
			sound_effect.change_audio_count(1)
			var new_audio: AudioStreamPlayer = AudioStreamPlayer.new()
			add_child(new_audio)
			new_audio.stream = sound_effect.sound_effect
			new_audio.volume_db = sound_effect.volume
			new_audio.pitch_scale = sound_effect.pitch_scale
			new_audio.pitch_scale += Global.rng.randf_range(-sound_effect.pitch_randomness, sound_effect.pitch_randomness )
			new_audio.finished.connect(sound_effect.on_audio_finished)
			new_audio.finished.connect(new_audio.queue_free)
			new_audio.play()
	else:
		push_error("Audio Manager failed to find setting for type ", type)
# Called every frame. 'delta' is the elapsed time since the previous frame.
