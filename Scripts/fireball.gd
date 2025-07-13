extends Node2D

@onready var attack_component: AttackComponent = $attack_component
@onready var sprite: AnimatedSprite2D = $Fireball_sprite

var direction := 1
var speed := 40
var damage := 1
var is_explode := false

func _process(delta: float) -> void:
	if !is_explode:
		position.x += 1.5*speed*delta*direction

func _on_attack_component_body_entered(body: Node2D) -> void:
	if !is_explode:
		is_explode = true
		AudioManager.create_audio(Sound_effect.SOUND_EFFECT_TYPE.fireball_explode)
		if body.is_in_group("player"):
			var fireball = Attack.new()
			fireball.attack_damage = damage
			fireball.isfireball = true
			await attack_component.attack(fireball)
			#self.attack_component.queue_free()
			sprite.play("explode")
			await sprite.animation_finished
		else: 
			sprite.play("attack")
			await sprite.animation_finished
			sprite.play("explode")
			await sprite.animation_finished
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
