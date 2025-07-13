extends Area2D

@onready var warning: Label = $Warning
@onready var game_manager: Node = %"Game Manager"
@export var target_level: PackedScene
@export var level:int

func _on_body_entered(body: Node2D) -> void:
	if game_manager.points >=3:
		print('You win!')
		game_manager.points == 0
		Global.unlocked_level = max(Global.unlocked_level,level)
		get_tree().change_scene_to_packed(target_level)
		print(target_level)
	else:
		print("Not enough points!")
		warning.show()
		await get_tree().create_timer(3).timeout
		warning.hide()
