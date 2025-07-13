extends CharacterBody2D
enum state {chill, alert, waiting}
var current_state = state.chill
@onready var vision_left: CollisionShape2D = $Longvision/vision_left
@onready var vision_right: CollisionShape2D = $Longvision/vision_right
@onready var alert_timer: Timer = $alert_timer
@onready var alert_symbol: AnimatedSprite2D = $alert_symbol
@onready var close_left: RayCast2D = $close_left
@onready var close_right: RayCast2D = $close_right
@onready var enemy: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_component: Area2D = $attack_component
@onready var cooldown_time: Timer = $attack_cooldown
@onready var buffer_time: Timer = $buffer_time
@onready var on_screen_checker: VisibleOnScreenNotifier2D = $on_screen_checker
@onready var walk: Timer = $walk


var speed := 30
var direction :=1
var player_pos
var attackdamage := 1.0
var attackknockback := 1.0
var attackbuffer := 0.5
var attackcooldown = 1.5
var charge := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown_time.set_wait_time(attackcooldown)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if current_state == state.alert:
		alert_symbol.visible = true
		
		if player_pos < 0: #check if player is on the left or right
			#run to right
			direction = 1
			enemy.flip_h = false
		else:
			#run to left
			direction = -1
			enemy.flip_h = true
		attack_component.scale.x = direction
		
		#check if colliding with player or other enemy and if its facing in that direction
		if ((close_left.is_colliding()==false && direction == -1) || (close_right.is_colliding()==false && direction == 1))&& !charge:
			enemy.play("running")
			position.x += 1.5*speed*delta*direction

		var left_collider = close_left.get_collider() 
		var right_collider = close_right.get_collider() 
		if (left_collider!=null && left_collider.is_in_group("player") or (right_collider!=null && right_collider.is_in_group("player")) ) && cooldown_time.time_left == 0 && !charge:
			var attack = Attack.new()
			attack.attack_damage = attackdamage
			attack.attack_knockback = attackknockback
			attack.attack_cooldown = attackcooldown
			attack.attack_buffer = attackbuffer
			attack.attack_direction = direction
			attack.isfireball = false
			print("prepare attack")
			charge = true
			enemy.play("buffer")
			await enemy.animation_finished
			#await get_tree().create_timer(attackbuffer).timeout
			await attack_component.attack(attack)
			charge =  false
			cooldown_time.start()
		
	elif current_state == state.chill:
		enemy.play("running")
		alert_symbol.visible = false
		#check if it is touching wall or other enemy
		if close_left.is_colliding():
			#walk right
			direction = 1
			enemy.flip_h = false
		if close_right.is_colliding():
			#walk left
			direction = -1
			enemy.flip_h = true
		#change position
		position.x += speed*delta*direction
		
	elif current_state == state.waiting:
		enemy.play("default")
		charge =  false

	#if current_state != state.waiting:
		#if on_screen_checker.is_on_screen() and walk.time_left == 0:
			#if randi_range(0, 1):
				#AudioManager.create_audio(Sound_effect.SOUND_EFFECT_TYPE.walk1)
			#else:
				#AudioManager.create_audio(Sound_effect.SOUND_EFFECT_TYPE.walk2)
			#walk.start()

#activate when player enters vision
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		current_state = state.alert
		alert_timer.set_paused(true)
		player_pos = position.x - body.position.x
		print(player_pos)
#activate when player leaves vision
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		current_state = state.waiting
		alert_timer.start()
		alert_timer.set_paused(false)

func _on_timer_timeout() -> void:
	current_state = state.chill
