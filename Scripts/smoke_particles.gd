extends Node2D
@onready var small_particles: CPUParticles2D = $"small particles"
@onready var big_particles: CPUParticles2D = $"Big particles"

func emitsmoke(direction: int) -> void:
	big_particles.direction.x = direction
	small_particles.direction.x = direction
	big_particles.emitting = true
	small_particles.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
