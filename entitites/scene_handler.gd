extends Node2D

@export var MN: MainMenu
@export var lvl_sl: LevelSelector

const GAME_HANDLER_SCENE: PackedScene = preload("res://core/game_handler.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("screen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	

func _ready() -> void:
	MN.level_selection.connect(func() -> void:
		MN.hide()
		lvl_sl.show()
	)
	
	lvl_sl.go_back.connect(func() -> void:
		MN.show()
		lvl_sl.hide()
	)
	
	lvl_sl.level_selected.connect(play)
	MN.settings.connect(func() -> void:
		MN.hide()
		var settings: Settings = load("res://entitites/settings.tscn").instantiate()
		settings.go_back.connect(func() -> void:
			settings.queue_free()
			MN.show()
		)
		$CanvasLayer.add_child(settings)
	)
	

func play(lvl: int) -> void:
	var game_handler: GameHandler = GAME_HANDLER_SCENE.instantiate()
	game_handler.load_level(lvl)
	game_handler.get_node("GUI/Pause").leave.connect(func() -> void:
		game_handler.queue_free()
		MN.hide()
		lvl_sl.show()
	)
	add_child(game_handler)
	MN.hide()
	lvl_sl.hide()
