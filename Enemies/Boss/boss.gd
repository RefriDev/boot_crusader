extends CharacterBody2D

@onready var spider := preload("res://Enemies/Spider/spider.tscn")
@onready var bat := preload("res://Enemies/Bat/Bat.tscn")
@onready var statue := preload("res://Enemies/Statue/statue.tscn")
@onready var spawner_left := $Spawner_Left
@onready var spawner_right := $Spawner_Right

@onready var left_timer := $Spawn_Timer_Left
@onready var right_timer := $Spawn_Timer_Right

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	left_timer.start()

func spawn_enemy_right():
	rng.randomize()
	var num = rng.randi_range(1,3)
	if num == 1:
		var ins_spider = spider.instantiate()
		get_parent().add_child(ins_spider)
		ins_spider.position.y = global_position.y - 57
		ins_spider.position.x = global_position.x + 80

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
	right_timer.start()
	spawn_enemy_left()
	left_timer.stop()
	left_timer.start()
	
