extends Node

var LEVEL_1 = load("res://Scene/Levels/level_1.tscn")
var LEVEL_2 = load("res://Scene/Levels/level_2.tscn")
var LEVEL_3 = load("res://Scene/Levels/level_3.tscn")
var LEVEL_4 = load("res://Scene/Levels/level_4.tscn")
var LEVEL_5 = load("res://Scene/Levels/level_5.tscn")

@onready var level_1: Button = $"Buttons/level 1"
@onready var level_2: Button = $"Buttons/level 2"
@onready var level_3: Button = $"Buttons/level 3"
@onready var level_4: Button = $"Buttons/level 4"
@onready var level_5: Button = $"Buttons/level 5"
@onready var level_buttons : Array[Button] = [level_1,level_2,level_3,level_4,level_5]

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_1)

func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_2)

func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_3)

func _on_level_4_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_4)

func _on_level_5_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_5)

func _ready() -> void:
	for i in range(Global.unlocked_level):
		level_buttons[i+1].disabled = false
		print(i+1)
