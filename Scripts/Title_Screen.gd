extends Control

var sfx_bus = AudioServer.get_bus_index("Sfx")
var music_bus = AudioServer.get_bus_index("Music")

@onready var back_focus := $Options/Back_Focus
@onready var slider := $Options/Mater/HSlider
@onready var options := $Options
@onready var play_button := $Play_Button
@onready var options_button := $Options_Button
@onready var play_focus := $Play_Focus
@onready var options_focus := $Options_Focus
@onready var focus_sound := $Focus_Sound

func _ready() -> void:
	options.visible = false
	play_button.grab_focus()
	play_focus.play("default")
	options_focus.play("default")
	back_focus.play("default")

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


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, value)
	AudioServer.set_bus_volume_db(music_bus, value)
	if value <= -30:
		AudioServer.set_bus_mute(sfx_bus, true)
		AudioServer.set_bus_mute(music_bus, true)
	
	else:
		AudioServer.set_bus_mute(sfx_bus, false)
		AudioServer.set_bus_mute(music_bus, false)


func _on_options_button_pressed() -> void:
	options.visible = true
	slider.grab_focus()
	


func _on_back_button_focus_entered() -> void:
	focus_sound.play()
	back_focus.visible = true


func _on_back_button_pressed() -> void:
	options.visible = false
	options_button.grab_focus()


func _on_h_slider_focus_entered() -> void:
	focus_sound.play()
	back_focus.visible = false
