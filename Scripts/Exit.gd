extends Node2D

@onready var animation := $AnimatedSprite2D
@onready var door_open_sound := $Door_Open_Sound
@onready var door_close_sound := $Door_Close_Sound

var can_exit := false

func _ready() -> void:
	animation.play("closed")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("INTERACT"):
		if Global.gem == true:
			if Global.lvl_on == 1:
				Global.gem1 = true
			if Global.lvl_on == 2:
				Global.gem2 = true
			if Global.lvl_on == 3:
				Global.gem3 = true
			if Global.lvl_on == 4:
				Global.gem4 = true
			if Global.lvl_on == 5:
				Global.gem5 = true
			Global.gem = false
		
		Global.start_boot_points = Global.boot_points
		Global.health = 3
		Global.lvl_completed[Global.lvl_on-1] = true
		Global.lvl_on += 1
			
		get_tree().change_scene_to_file("res://Scenes/map/new_map.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		door_open_sound.play()
		animation.play("open")
		can_exit = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		door_close_sound.play()
		animation.play("closed")
		can_exit = false
