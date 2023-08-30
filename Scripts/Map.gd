extends Control

@onready var animations := $AnimationPlayer
@onready var timer := $Enter_Level_Timer

@onready var map_move_sound := $Map_Move
@onready var map_click_sound := $Map_Click
@onready var map_click_timer := $Click_Timer

var timer_timeout := false

var counter := 0

func _ready() -> void:
	map_move_sound.play()
	timer.set_wait_time(3)
	
	if Global.lvl_on == 1:
		animations.play("enter_lvl_1")
		map_click_sound.pitch_scale = 0.1
		map_click_sound.play()
	if Global.lvl_on == 2:
		animations.play("move_lvl_2")
		map_click_timer.start()
	if Global.lvl_on == 3:
		animations.play("move_lvl_3")
		map_click_timer.start()
	if Global.lvl_on == 4:
		animations.play("move_lvl_4")
		map_click_timer.start()
	if Global.lvl_on == 5:
		animations.play("move_lvl_5")
		map_click_timer.start()
		

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "move_lvl_2":
		map_click_timer.queue_free()
		map_click_sound.pitch_scale = 0.1
		map_click_sound.play()
		animations.play("enter_lvl_2")
		timer.start()
	if anim_name == "move_lvl_3":
		map_click_timer.queue_free()
		map_click_sound.pitch_scale = 0.1
		map_click_sound.play()
		animations.play("enter_lvl_3")
		timer.start()
	if anim_name == "move_lvl_4":
		map_click_timer.queue_free()
		map_click_sound.pitch_scale = 0.1
		map_click_sound.play()
		animations.play("enter_lvl_4")
		timer.start()
	if anim_name == "move_lvl_5":
		map_click_timer.queue_free()
		map_click_sound.pitch_scale = 0.1
		map_click_sound.play()
		animations.play("enter_lvl_5")
		timer.start()

	if anim_name == "enter_lvl_1":
		counter += 1
		animations.play("enter_lvl_1")
		if counter >= 3:
			get_tree().change_scene_to_file("res://Scenes/Levels/Level_1.tscn")
	if anim_name == "enter_lvl_2":
		counter += 1
		animations.play("enter_lvl_2")
		if counter >= 3:
			get_tree().change_scene_to_file("res://Scenes/Levels/Level_1.tscn")
	if anim_name == "enter_lvl_3":
		counter += 1
		animations.play("enter_lvl_3")
		if counter >= 3:
			get_tree().change_scene_to_file("res://Scenes/Levels/Level_1.tscn")
	if anim_name == "enter_lvl_4":
		counter += 1
		animations.play("enter_lvl_4")
		if counter >= 3:
			get_tree().change_scene_to_file("res://Scenes/Levels/Level_1.tscn")
	if anim_name == "enter_lvl_5":
		counter += 1
		animations.play("enter_lvl_5")
		if counter >= 3:
			get_tree().change_scene_to_file("res://Scenes/Levels/Level_1.tscn")

func _on_enter_level_timer_timeout() -> void:
	timer_timeout = true


func _on_click_timer_timeout() -> void:
	map_click_sound.play()
	map_click_timer.stop()
	map_click_timer.set_wait_time(0.3)
	map_click_timer.start()
