extends CharacterBody2D

@export var RISE_ACC := 100
@export var RISE_SPEED := 300
@export var FALL_ACC := 50
@export var FALL_SPEED := 200

@onready var animation := $AnimatedSprite2D
@onready var statue := $Path2D/PathFollow2D/Statue
@onready var top_col := $Top_Area/CollisionShape2D
@onready var col := $CollisionShape2D
@onready var activate_col := $Activate_Area/CollisionShape2D
@onready var path := $Path2D/PathFollow2D
@onready var player := get_parent().get_node("Player")

@onready var rise_timer := $Rise_Timer
@onready var reset_timer := $Reset_Timer

var can_move := false
var t := 0.0
var dead := false
var add_point := true

var is_attacking := false
var is_falling := false
var is_flying := false
var begin_fall := false

func _ready() -> void:
	can_move = true
	is_falling = true
	statue.visible = false
	animation.play("idle")

func _physics_process(delta: float) -> void:
	
	if dead == true:
		can_move = false
		death(delta)
		if add_point == true:
			Global.boot_points += 1
			add_point = false
	
	if can_move == true:
		
		if is_attacking == true:
			animation.play("attack")
			if animation.frame == 9:
				velocity.y -= RISE_ACC
				rise_timer.start()
				reset_timer.start()
				activate_col.set_deferred("disabled", true)
				
				
		
		if is_flying == true:
			animation.play("idle")
			var player_pos = player.global_position
			global_position.x = player_pos.x
			global_position.y = player_pos.y - 100
		
			velocity.x = 0
			velocity.y = 0
			is_flying = false
			is_falling = true
		
		if is_falling == true:
			velocity.y += FALL_ACC
			if is_on_floor():
				velocity.y = 0
				is_falling = false
				animation.play("idle")
				
		
		velocity.y = clamp(velocity.y, -RISE_SPEED, FALL_SPEED)
		
		move_and_slide()

func _on_top_area_area_entered(area: Area2D) -> void:
	if area.name == "Boots":
		top_col.set_deferred("disabled", true)
		col.set_deferred("disabled", true)
		animation.visible = false
		statue.visible = true
		can_move = false
		dead = true
		
func death(delta):
	t += delta
	path.progress = t * 140
	
	if t > 1:
		queue_free()


func _on_activate_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_move = true
		is_attacking = true
	


func _on_rise_timer_timeout() -> void:
	rise_timer.stop()
	is_attacking = false
	is_flying = true


func _on_reset_timer_timeout() -> void:
	activate_col.set_deferred("disabled", false)
