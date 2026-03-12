extends Node2D

signal picked_up

func _on_area_2d_body_entered(body: Node2D) -> void:
	$Explosion.play()
	picked_up.emit()
	$Sprite2D.visible = false
	call_deferred("p")
	$KeyPickup.play()
	
	await $Explosion.finished
	queue_free()

func p() -> void:
	$Area2D.monitoring = false
