extends Control

@onready var play_button := $Play_Button
@onready var options_button := $Options_Button
@onready var play_focus := $Play_Focus
@onready var options_focus := $Options_Focus
@onready var focus_sound := $Focus_Sound

func _ready() -> void:
	play_button.grab_focus()
	play_focus.play("default")
	options_focus.play("default")

func _on_play_button_focus_entered() -> void:
	focus_sound.play()
	options_focus.visible = false
	play_focus.visible = true

func _on_options_button_focus_entered() -> void:
	focus_sound.play()
	options_focus.visible = true
	play_focus.visible = false


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/map/new_map.tscn")
