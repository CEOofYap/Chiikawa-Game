extends Area2D
class_name AttackComponent

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

func attack(attack_details:Attack):
#	attack_cooldown.set_wait_time(attack_details.attack_cooldown)
	if animated_sprite_2d != null:
		animated_sprite_2d.play("attack")
		await animated_sprite_2d.animation_finished
	print("attacking")
	for area in get_overlapping_areas():
		if area is HitboxComponent:
			var hitbox : HitboxComponent = area
			hitbox.damage(attack_details)

#	if attack_cooldown.time_left == 0:
#		attack_cooldown.start()
