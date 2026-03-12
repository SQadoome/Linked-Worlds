class_name GameHandler
extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		time_stop()
	

var already_stopped: int = 1
func _ready() -> void:
	randomize()
	time_stop(false)

var ascensions: int = 0
func player_ascended() -> void:
	ascensions += 1
	if ascensions >= 2:
		ascensions = 0
		
		$AnimationPlayer.play("appear")
		await $AnimationPlayer.animation_finished
		
		load_level(level_index + 1)

func time_stop(play_sound: bool = true) -> void:
	if play_sound:
		$Freeze.pitch_scale = randf_range(0.9, 1.1)
		$Freeze.play()
	
	if already_stopped == 0:
		# pink
		already_stopped = 1
		
		for i in level.get_node("Player1Stuff").get_children():
			i.freeze()
		
		for i in level.get_node("Player2Stuff").get_children():
			i.unfreeze()
		
	else:
		# blue
		already_stopped = 0
		
		for i in level.get_node("Player2Stuff").get_children():
			i.freeze()
		
		for i in level.get_node("Player1Stuff").get_children():
			i.unfreeze()
		

func add_bird(bird: Bird) -> void:
	level.get_node("Player1Stuff").add_child(bird)

const level_1: PackedScene = preload("res://levels/level_1.tscn")
const level_2: PackedScene = preload("res://levels/level_2.tscn")
const level_3: PackedScene = preload("res://levels/level_3.tscn")
const level_4: PackedScene = preload("res://levels/level_4.tscn")
const level_5: PackedScene = preload("res://levels/level_5.tscn")
const level_6: PackedScene = preload("res://levels/level_6.tscn")
const level_7: PackedScene = preload("res://levels/level_7.tscn")
const level_8: PackedScene = preload("res://levels/level_8.tscn")
const level_9: PackedScene = preload("res://levels/level_9.tscn")
const level_10: PackedScene = preload("res://levels/level_10.tscn")
const level_11: PackedScene = preload("res://levels/level_11.tscn")
const level_12: PackedScene = preload("res://levels/level_12.tscn")
const level_13: PackedScene = preload("res://levels/level_13.tscn")

var level: Node2D
var level_index: int = 1
var level_data: Dictionary[int, PackedScene] = {
	1: level_1,
	2: level_2,
	3: level_3,
	4: level_4,
	5: level_5,
	6: level_6,
	7: level_7,
	8: level_8,
	9: level_9,
	10: level_10,
	11: level_11,
	12: level_12,
	13: level_13,
}

func _on_reset_pressed() -> void:
	level.queue_free()
	level = level_data[level_index].instantiate()
	get_node("Main").add_child(level)
	time_stop(0)
	$GUI/Reset.release_focus()

func load_level(lvl: int) -> void:
	if level != null:
		level.queue_free()
	var x: int = floori((lvl - 1) / 4.0) + 1
	var y: int = lvl % 4
	if y == 0:
		y = 4
	
	$GUI/Label.text = str(x) + "-" + str(y)
	
	level_index = lvl
	level = level_data[lvl].instantiate()
	get_node("Main").add_child(level)
	time_stop(0)
	
	$AnimationPlayer.play("disappear")
	
