extends CharacterBody2D

@onready var spider := preload("res://Enemies/Spider/spider.tscn")
@onready var bat := preload("res://Enemies/Bat/Bat.tscn")
@onready var statue := preload("res://Enemies/Statue/statue.tscn")
@onready var spawner_left := $Spawner_Left
@onready var spawner_right := $Spawner_Right
@onready var animation := $AnimationPlayer
@onready var left_timer := $Spawn_Timer_Left
@onready var right_timer := $Spawn_Timer_Right
@onready var top_col := $Top_Area/CollisionShape2D
@onready var down_timer := $Down_Timer
@onready var label := $Label
@onready var music := $Boss_Music
@onready var heartbeat_timer1 := $HeartBeat_Timer
@onready var heartbeat_timer2 := $HeartBeat_Timer2
@onready var heart_sound := $HeartBeat_Sound


var rng = RandomNumberGenerator.new()

var health := 250
var play_animation := true

func _ready() -> void:
	heart_sound.play()
	heartbeat_timer1.start()
	Global.boss_boot_points = Global.boot_points
	top_col.set_deferred("disabled", true)
	animation.play("idle")

func  _physics_process(delta: float) -> void:
	if health >= 0:
		label.text = str(health)
	else:
		get_tree().change_scene_to_file("res://win.tscn")
		label.text = str(0)
	#print(Global.round)
	if Global.round == true:
		left_timer.stop()
		right_timer.stop()
		if play_animation == true:
			animation.play("fall")
			play_animation = false
	
func spawn_enemy_right():
	rng.randomize()
	var num = rng.randi_range(1,3)
	if num == 1:
		var ins_spider = spider.instantiate()
		get_parent().add_child(ins_spider)
		ins_spider.position.y = global_position.y - 57
		ins_spider.position.x = global_position.x + 80
	if num == 2:
		var ins_bat = bat.instantiate()
		get_parent().add_child(ins_bat)
		ins_bat.position.y = global_position.y - 57
		ins_bat.position.x = global_position.x + 80
	if num == 3:
		var ins_statue = statue.instantiate()
		get_parent().add_child(ins_statue)
		ins_statue.position.y = global_position.y - 57
		ins_statue.position.x = global_position.x + 80

func spawn_enemy_left():
	rng.randomize()
	var num = rng.randi_range(1,3)
	if num == 1:
		var ins_spider = spider.instantiate()
		get_parent().add_child(ins_spider)
		ins_spider.position.y = global_position.y - 57
		ins_spider.position.x = global_position.x - 80
	if num == 2:
		var ins_bat = bat.instantiate()
		get_parent().add_child(ins_bat)
		ins_bat.position.y = global_position.y - 57
		ins_bat.position.x = global_position.x - 80
	if num == 3:
		var ins_statue = statue.instantiate()
		get_parent().add_child(ins_statue)
		ins_statue.position.y = global_position.y - 57
		ins_statue.position.x = global_position.x - 80
	

func _on_spawn_timer_right_timeout() -> void:
	spawn_enemy_right()
	right_timer.stop()
	right_timer.start()
	


func _on_spawn_timer_left_timeout() -> void:
	spawn_enemy_left()
	left_timer.stop()
	left_timer.start()
	


func _on_top_area_area_entered(area: Area2D) -> void:
	if area.name == "Boots":
		health -= Global.boot_points


func _on_down_timer_timeout() -> void:
	play_animation = true
	Global.round = false
	top_col.set_deferred("disabled", true)
	animation.play("up")
	Global.boss_boot_points = Global.boot_points
	left_timer.start()
	right_timer.start()
	down_timer.stop()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fall":
		down_timer.start()
		top_col.set_deferred("disabled", false)
	
	if anim_name == "up":
		animation.play("idle")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		right_timer.start()
		left_timer.start()
		music.play()


func _on_heart_beat_timer_timeout() -> void:
	pass # Replace with function body.


func _on_heart_beat_timer_2_timeout() -> void:
	pass # Replace with function body.
