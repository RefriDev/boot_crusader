extends Control

@onready var start_text := $Start
@onready var animation := $AnimationPlayer
@onready var empty_hearts := $HP/Empty_Hearts
@onready var full_hearts := $HP/Full_Hearts
@onready var gem := $Gem/Full_Gem
@onready var boot_number := $Kills/Numbers

@onready var death_screen := $DeathScreen
@onready var retry_button := $DeathScreen/Retry_Button
@onready var retry_focus := $DeathScreen/Retry_Focus
@onready var quit_button := $DeathScreen/Quit_Button
@onready var quit_focus := $DeathScreen/Quit_Focus

var heart_size := 12
var death_end := false

func _ready() -> void:
	death_screen.visible = false
	gem.visible = false
	animation.play("start")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "start":
		start_text.visible = false
	
	if anim_name == "death":
		death_end = true
		retry_button.grab_focus()

func _process(_delta: float) -> void:
	
	if Global.dead == true:
		if death_end == false:
			death_screen.visible = true
			animation.play("death")
		
	
	full_hearts.size.x = heart_size * Global.health
	
	if Global.health == 0:
		full_hearts.scale.x = 0
	
	if Global.gem == true:
		gem.visible = true
	
	if Global.boot_points <= 9:
		boot_number.text = "00" + str(Global.boot_points)
	elif Global.boot_points >= 9 and Global.boot_points <= 99:
		boot_number.text = "0" + str(Global.boot_points)
	else:
		boot_number.text = str(Global.boot_points)


func _on_retry_button_focus_entered() -> void:
	retry_focus.visible = true
	quit_focus.visible = false

func _on_quit_button_focus_entered() -> void:
	retry_focus.visible = false
	quit_focus.visible = true



func _on_retry_button_pressed() -> void:
	Global.dead = false
	if Global.gem == true:
		Global.gem = false
	
	Global.boot_points = Global.start_boot_points
	
	get_tree().change_scene_to_file("res://Scenes/map/new_map.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TitleScreen/title_screen.tscn")
