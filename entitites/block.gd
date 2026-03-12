class_name Block
extends StaticBody2D

func freeze() -> void:
	set_physics_process(false)
	$Freezable.freeze()

func unfreeze() -> void:
	set_physics_process(true)
	$Freezable.unfreeze()
