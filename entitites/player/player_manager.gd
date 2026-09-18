class_name PlayerManager
extends Node2D

var frozen: bool = false

func freeze() -> void:
	if (frozen):
		return;
	
	for child:Node2D in get_children():
		child.freeze();
		frozen = true;
	

func unfreeze() -> void:
	if (not frozen):
		return;
	
	for child:Node2D in get_children():
		child.unfreeze();
		frozen = false;
	
