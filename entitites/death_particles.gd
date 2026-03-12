extends CPUParticles2D

const PINK: Gradient = preload("res://assets/pink_grad.tres")
const BLUE: Gradient = preload("res://assets/blue_grad.tres")

func play(type: int) -> void:
	if type == 1:
		color_ramp = PINK
	else:
		color_ramp = BLUE
	
	emitting = true
	finished.connect(queue_free)
	
