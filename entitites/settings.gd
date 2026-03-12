class_name Settings
extends Control

signal go_back

func _ready() -> void:
	$HSlider.drag_started.connect(func() -> void: set_process(true))
	$HSlider.drag_ended.connect(func(_v: int) -> void:
		set_process(false)
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index("Master"), ($HSlider.value - 65) / 5.0
		)
		$AudioStreamPlayer.play()
	)

func _on_button_pressed() -> void:
	go_back.emit()

func _on_button_2_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		$Button.text = "Minimize"
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		$Button.text = "Fullscreen"
