extends Player

@onready var block: Block = get_tree().get_first_node_in_group("Block")

var picked_up: bool = false
var last: int = 1

func _unhandled_input(event: InputEvent) -> void:
	super(event)
	if event.is_action_pressed("right_click"):
		if picked_up:
			throw_block()
		else:
			pickup_block()
	

func _physics_process(delta: float) -> void:
	super(delta)
	if picked_up:
		if x_direction != 0:
			last = x_direction
		
		if last == 1:
			$Hand.scale.x = 1
			block.global_position = global_position + Vector2(8, -1)
		if last == -1:
			$Hand.scale.x = -1
			block.global_position = global_position + Vector2(-8, -1)
	

func pickup_block() -> void:
	if block == null:
		block = get_tree().get_first_node_in_group("Block")
	
	if global_position.distance_to(block.global_position) < 16:
		picked_up = true
		set_collision_mask_value(2, false)
		$Hand.visible = true

func throw_block() -> void:
	$Hand.visible = false
	picked_up = false
	set_collision_mask_value(2, true)
