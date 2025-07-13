extends Node2D
class_name HealthComponent
var health : float
@export var MAX_HEALTH := 3.0
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var timer: Timer = $"../AnimatedSprite2D/Timer"
@onready var smoke_particles: Node2D = $"Smoke particles"
signal health_changed()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = MAX_HEALTH
	
func damage(attack: Attack):
	var parent = get_parent()
	health -= attack.attack_damage
	if parent.is_in_group("player"):
		parent.health_left -= attack.attack_damage
		emit_signal("health_changed")
		
	animated_sprite_2d.modulate = Color(10,10,10,10)
	if !attack.isfireball:
		await smoke_particles.emitsmoke(attack.attack_direction)
	print(parent, ": ", health)
	timer.start()
	if health <= 0 && !get_parent().is_in_group("player"):
		await get_tree().create_timer(0.4).timeout
		get_parent().queue_free()


func _on_timer_timeout() -> void:
	animated_sprite_2d.modulate = Color(1,1,1,1)
