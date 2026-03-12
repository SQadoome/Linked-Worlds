extends Node2D

func _ready() -> void:
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.finished.connect(func() -> void:
		get_tree().get_first_node_in_group("GameHandler").get_node("GUI/Pause").leave.emit()
	)
