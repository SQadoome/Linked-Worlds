class_name Bird
extends CharacterBody2D

signal died

var speed: float = 45.0
var dir: int = -1

func invert() -> void:
	dir = 1

func _ready() -> void:
	get_node("Sprite2D").scale.x = dir*-1

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(Vector2(speed*dir, 0)*delta)
	
	if collision != null:
		if $AnimationPlayer.is_playing() == true:
			$AnimationPlayer.pause()
	else:
		if $AnimationPlayer.is_playing() == false:
			$AnimationPlayer.play()
	
	if dir == -1:
		if position.x < -20:
			die()
	else:
		if position.x > 380:
			die()
	

func die() -> void:
	$AudioStreamPlayer.play()
	set_physics_process(false)
	died.emit()
	$Freezable.hide()
	$Sprite2D.hide()
	$CollisionShape2D.disabled = true
	$CPUParticles2D.emitting = true

func _on_cpu_particles_2d_finished() -> void:
	queue_free()

func freeze() -> void:
	$AnimationPlayer.pause()
	set_physics_process(false)
	$Freezable.freeze()

func unfreeze() -> void:
	$AnimationPlayer.play()
	set_physics_process(true)
	$Freezable.unfreeze()
