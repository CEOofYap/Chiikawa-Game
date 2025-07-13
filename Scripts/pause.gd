extends Node

@onready var pause_panel: Panel = $"Pause Panel"
@onready var resume: Button = $"Pause Panel/VBoxContainer/Resume"


func _on_button_pressed() -> void:
	pause_panel.visible =true
	get_tree().paused = true


func _on_resume_pressed() -> void:
	pause_panel.visible =false
	get_tree().paused = false


func _on_back_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scene/Menu/main_menu.tscn")


func _on_restart_level_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
