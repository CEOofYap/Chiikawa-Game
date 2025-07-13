extends Node

@onready var death: Panel = %Death
@export var hearts: Array[Node]
@onready var points_label: Label = %PointsLabel
@onready var chiikawa: CharacterBody2D = $"../Chiikawa"


var points := 0
@export var lives := 3

func _ready() -> void:
	pass
	
func add_point():
	points+=1
	print(points)
	points_label.text = "Keys: " + str(points)

func decrease_health():
	lives -= 1
	for h in 3:
		if h <lives:
			hearts[h].show()
		else:
			hearts[h].hide()
	if lives <= 0:
		chiikawa.hide()
		get_tree().paused = true
		death.show()


func _on_chiikawa_health_decrease() -> void:
	decrease_health()

func play_sound(type : Sound_effect.SOUND_EFFECT_TYPE):
	AudioManager.create_audio(type)
	print("playing sound")

func _on_worldborder_killzone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		lives = 0
		chiikawa.hide()
		get_tree().paused = true
		death.show()
