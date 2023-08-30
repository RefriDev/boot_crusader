extends Control

@onready var animations := $AnimationPlayer
@onready var timer := $Enter_Level_Timer

@onready var map_move_sound := $Map_Move
@onready var map_click_sound := $Map_Click
@onready var map_click_timer := $Click_Timer
@onready var begin_timer := $Begin_Timer

@onready var lvl1 := $Levels/Lvl_1
@onready var lvl2 := $Levels/Lvl_2
@onready var lvl3 := $Levels/Lvl_3
@onready var lvl4 := $Levels/Lvl_4
@onready var lvl5 := $Levels/Lvl_5

@onready var dots := $Dots
@onready var road := $Road
@onready var player := $Player

var timer_timeout := false

var counter := 0
var begin_counter := 0

func _ready() -> void:
	timer.set_wait_time(3)
	
	if Global.lvl_on == 1:
		animations.play("begin")
		begin_timer.start()
		
	if Global.lvl_on == 2:
		dots.visible = true
		road.visible = true
		player.visible = true
		animations.play("move_lvl_2")
		map_click_timer.start()
		map_move_sound.play()
	if Global.lvl_on == 3:
		dots.visible = true
		road.visible = true
		player.visible = true
		animations.play("move_lvl_3")
		map_click_timer.start()
		map_move_sound.play()
	if Global.lvl_on == 4:
		dots.visible = true
		road.visible = true
		player.visible = true
		animations.play("move_lvl_4")
		map_click_timer.start()
		map_move_sound.play()
	if Global.lvl_on == 5:
		dots.visible = true
		road.visible = true
		player.visible = true
		animations.play("move_lvl_5")
		map_click_timer.start()
		map_move_sound.play()
	
	if Global.lvl_completed[0] == true:
		lvl1.visible = true
	if Global.lvl_completed[1] == true:
		lvl2.visible = true
	if Global.lvl_completed[2] == true:
		lvl3.visible = true
	if Global.lvl_completed[3] == true:
		lvl4.visible = true
	if Global.lvl_completed[4] == true:
		lvl5.visible = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "begin":
		animations.play("enter_lvl_1")
		map_click_sound.pitch_scale = 0.1
		map_click_sound.play()
		timer.start()
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


func _on_begin_timer_timeout() -> void:
	if begin_counter <= 2:
		map_click_sound.pitch_scale = 0.1
		map_click_sound.play()
		begin_timer.stop()
		begin_timer.set_wait_time(0.6)
		begin_timer.start()
		begin_counter += 1
