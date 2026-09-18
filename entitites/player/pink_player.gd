extends Player

const BIRD_SCENE: PackedScene = preload("res://entitites/bird.tscn")
var bird: Bird = null

@onready var particles: CPUParticles2D = $Sprite2D/CPUParticles2D
@onready var whistle: Sprite2D = $Sprite2D/Sprite2D2
@onready var ghost_bird: Sprite2D = get_tree().get_first_node_in_group("GhostBird")

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	if event.is_action_pressed("right_click"):
		ghost_bird.show()
	
	if event.is_action_released("right_click"):
		call_bird()
		ghost_bird.hide()
	

func _physics_process(delta: float) -> void:
	super(delta)
	if x_direction != 0 or not is_on_floor():
		
		if bird != null:
			kill_bird()
		
	

func _process(_delta: float) -> void:
	ghost_bird.position = get_global_mouse_position()
	if get_global_mouse_position().x < 320/2:
		ghost_bird.scale.x = -1
	else:
		ghost_bird.scale.x = 1
	

func call_bird() -> void:
	if bird != null:
		kill_bird()
	
	if bird == null:
		var new_bird: Bird = BIRD_SCENE.instantiate()
		new_bird.position.y = get_global_mouse_position().y
		new_bird.position.x = 400
		new_bird.died.connect(_on_bird_death)
		if get_global_mouse_position().x < 320/2:
			new_bird.invert()
			new_bird.position.x = -50
		
		
		game_handler.add_bird(new_bird)
		bird = new_bird
	
	whistle.visible = true
	$Timer.start()
	$AnimationPlayer.stop()
	pause_animation = true
	$Sprite2D.frame = 0
	particles.emitting = true
	$Whistle.pitch_scale = randf_range(0.9, 1.1)
	$Whistle.play()
	

func freeze() -> void:
	super()
	$Timer.stop()

func unfreeze() -> void:
	super()
	if bird != null:
		$Timer.start()
		$AnimationPlayer.stop()
		$Sprite2D.frame = 0

func _on_bird_death() -> void:
	if bird != null:
		whistle.visible = false
		$Timer.stop()
		pause_animation = false
	

func _on_bird_life_time_timeout() -> void:
	if bird != null:
		kill_bird()
	

func kill_bird() -> void:
	whistle.visible = false
	$Timer.stop()
	pause_animation = false
	
	bird.die()
	bird = null

func _on_timer_timeout() -> void:
	$Whistle.pitch_scale = randf_range(0.9, 1.1)
	$Whistle.play()
	particles.emitting = true
