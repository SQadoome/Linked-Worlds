class_name LevelSelector
extends Control

signal level_selected(lvl: int)
signal go_back

func _ready() -> void:
	$HBoxContainer/Level/Button.pressed.connect(level_selected.emit.bind(1))
	$HBoxContainer/Level2/Button.pressed.connect(level_selected.emit.bind(2))
	$HBoxContainer/Level3/Button.pressed.connect(level_selected.emit.bind(3))
	$HBoxContainer/Level4/Button.pressed.connect(level_selected.emit.bind(4))
	
	$HBoxContainer2/Level/Button.pressed.connect(level_selected.emit.bind(5))
	$HBoxContainer2/Level2/Button.pressed.connect(level_selected.emit.bind(6))
	$HBoxContainer2/Level3/Button.pressed.connect(level_selected.emit.bind(7))
	$HBoxContainer2/Level4/Button.pressed.connect(level_selected.emit.bind(8))
	
	
	$HBoxContainer3/Level/Button.pressed.connect(level_selected.emit.bind(9))
	$HBoxContainer3/Level2/Button.pressed.connect(level_selected.emit.bind(10))
	$HBoxContainer3/Level3/Button.pressed.connect(level_selected.emit.bind(11))
	$HBoxContainer3/Level4/Button.pressed.connect(level_selected.emit.bind(12))
	

func _on_button_pressed() -> void:
	go_back.emit()
