class_name Freezable
extends Node2D

const PARTICLES: PackedScene = preload("res://entitites/clock_particles.tscn")

@export var actor: Node2D

func freeze() -> void:
	actor.modulate = Color8(150, 150, 150, 255)
	$Clock.visible = true

func unfreeze() -> void:
	add_child(PARTICLES.instantiate())
	actor.modulate = Color8(255, 255, 255, 255)
	$Clock.visible = false
