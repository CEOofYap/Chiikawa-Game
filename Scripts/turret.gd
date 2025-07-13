extends Node2D
@onready var turret_sprite: AnimatedSprite2D = $"Turret Sprite"
@export var timer: Timer
@export var direction :int
@export var speed := 40
@onready var muzzle: Node2D = $Muzzle
@onready var turret: Node2D = $"."

func shoot(direction,speed):
	var scene_to_instance = preload("res://Scene/Game Object/fireball.tscn")
	var object = scene_to_instance.instantiate()
	if direction ==1:
		object.global_position = turret.global_position - muzzle.global_position
	else:
		object.global_position.y = turret.global_position.y - muzzle.global_position.y
		object.global_position.x = muzzle.global_position.x - turret.global_position.x
	object.direction = -1
	object.speed = speed
	add_child(object)


func _ready() -> void:
	#flipping the sprite to match the directions
	if direction == 1:
		turret.scale.x = -1
	else: 
		turret.scale.x = 1
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.start()

func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	shoot(direction, speed)
	turret_sprite.play("shoot")
