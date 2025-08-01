extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_component: AttackComponent = $AttackComponent
@onready var cooldown_timer: Timer = $attack_cooldown
@onready var buffer_time: Timer = $buffer_time
@export var health_left: float
@onready var walk: Timer = $walk

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var damage := 1.0
var knockback :=1.0
var cooldown := 1.0
var buffer := 0.1
var facing := 1
var is_attack = false
signal health_decrease

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if !is_attack:
			animated_sprite_2d.play("jump")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("run_left", "run_right")
	if direction:
		if direction == -1:
			animated_sprite_2d.flip_h = true
			facing = -1
		elif direction == 1:
			animated_sprite_2d.flip_h = false
			facing =1
		velocity.x = direction * SPEED
		if !is_attack and is_on_floor():
			animated_sprite_2d.play("running")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if !is_attack and is_on_floor():
			animated_sprite_2d.play("idle")
	attack_component.scale.x = facing
	if is_attack:
		velocity.x = 0
	move_and_slide()
	
	if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
		if not is_attack and is_on_floor() and walk.time_left == 0:
			if Global.rng.randi_range(0 , 1):
				AudioManager.create_audio(Sound_effect.SOUND_EFFECT_TYPE.walk1)
			else:
				AudioManager.create_audio(Sound_effect.SOUND_EFFECT_TYPE.walk2)
			walk.start()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") && cooldown_timer.time_left==0:
		cooldown_timer.start()
		var attack = Attack.new()
		attack.attack_damage = damage
		attack.attack_knockback = knockback
		attack.attack_cooldown = cooldown
		attack.attack_buffer = buffer
		attack.attack_direction = facing
		attack.isfireball = false
		is_attack = true
		if Global.rng.randi_range(0 , 1):
			AudioManager.create_audio(Sound_effect.SOUND_EFFECT_TYPE.chiikawa_attack1)
		else:
			AudioManager.create_audio(Sound_effect.SOUND_EFFECT_TYPE.chiikawa_attack2)
		animated_sprite_2d.play("buffer")
		await get_tree().create_timer(buffer).timeout
		await attack_component.attack(attack)
		is_attack = false
		buffer_time.start()


func _on_health_component_health_changed() -> void:
	emit_signal("health_decrease")
	if Global.rng.randi_range(0 , 1):
		AudioManager.create_audio(Sound_effect.SOUND_EFFECT_TYPE.get_hit1)
	else:
		AudioManager.create_audio(Sound_effect.SOUND_EFFECT_TYPE.get_hit2)
