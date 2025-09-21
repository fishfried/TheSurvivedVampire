extends Node

@export var end_screen_scene: PackedScene

var pause_menu_scene = preload("res://scenes/UI/pause_menu.tscn")

func _ready() :
	$%player.health_component.died.connect(on_player_died)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()
		

func on_player_died():
	clear_all_entities()
	await get_tree().create_timer(0.4).timeout
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
	MetaProgression.save()

func clear_all_entities() -> void:
	# 先收集，再删除，避免遍历时改数组
	for entities in get_tree().current_scene.find_children("Entities", "", true, false):
		entities.queue_free()
