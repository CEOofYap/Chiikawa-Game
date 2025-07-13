extends ParallaxLayer
@export var Cloud_Speed := -15.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.motion_offset.x += Cloud_Speed * delta
