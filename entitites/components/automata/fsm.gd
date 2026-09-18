class_name FSM
extends Node

@export var starting_state: State

var active_state: State

func _enter_tree() -> void:
	assert(is_instance_valid(starting_state));
	
	active_state
	

func switch_state(state: State) -> void:
	state.enter_state;
	
