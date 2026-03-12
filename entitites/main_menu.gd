class_name MainMenu
extends Control

signal level_selection
signal settings

func _ready() -> void:
	$VBoxContainer/Play.pressed.connect(level_selection.emit)
	$VBoxContainer/Settings.pressed.connect(settings.emit)
	$VBoxContainer/Depart.pressed.connect(func(): get_tree().quit())
	
