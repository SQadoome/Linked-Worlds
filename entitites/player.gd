class_name Player
extends CharacterBody2D

var x_direction: int = 0
var speed: float = 35.0
var gravity: float = 8.3
var pause_animation: bool = false

@export var type: int
@onready var game_handler: GameHandler = get_tree().get_first_node_in_group("GameHandler")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -150
		$AudioStreamPlayer.pitch_scale = randf_range(1.3, 1.6)
		$AudioStreamPlayer.play()

func _physics_process(delta: float) -> void:
	x_direction = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	var particles: CPUParticles2D = $RunParticles
	
	if x_direction != 0:
		$Sprite2D.scale.x = x_direction
		if $AnimationPlayer.is_playing() == true:
			$AnimationPlayer.stop()
		
		if particles.emitting == false:
			particles.emitting = true
		
		if x_direction == -1:
			particles.position = Vector2(4, 7)
			particles.rotation_degrees = -22
		else:
			particles.position = Vector2(-5, 7)
			particles.rotation_degrees = -135
		
		$Sprite2D.frame = 3
	else:
		if particles.emitting == true:
			particles.emitting = false
		if $AnimationPlayer.is_playing() == false and not pause_animation:
			$AnimationPlayer.play("idle")
	
	if not is_on_floor():
		if particles.emitting == true:
			particles.emitting = false
	 
	velocity.x = speed*x_direction
	velocity.y += gravity
	
	move_and_slide()

func freeze() -> void:
	var particles: CPUParticles2D = $RunParticles
	particles.emitting = false
	
	set_physics_process(false)
	set_process_unhandled_input(false)
	var anim: AnimationPlayer = $AnimationPlayer
	anim.stop()
	$Freezable.freeze()

func unfreeze() -> void:
	set_physics_process(true)
	set_process_unhandled_input(true)
	var anim: AnimationPlayer = $AnimationPlayer
	anim.play("idle")
	$Freezable.unfreeze()
