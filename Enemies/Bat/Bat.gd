extends CharacterBody2D

@export var MAX_SPEED : int = 150
@export var ACCELERATION : int = 20
@export var FALL : int = 10
@export var MAX_FALL : = 150

@onready var raycast_left2 := $RayCast2D_Left2
@onready var raycast_right2 := $RayCast2D_Right2
@onready var raycast_left := $RayCast2D_Left
@onready var raycast_right := $RayCast2D_Right
@onready var animation := $AnimatedSprite2D
@onready var top_col := $Top_Area/CollisionShape2D
@onready var col := $CollisionShape2D
@onready var left_col := $Detect_Area_Left/CollisionShape2D
@onready var right_col := $Detect_Area_Right/CollisionShape2D
@onready var path := $Path2D/PathFollow2D
@onready var bat := $Path2D/PathFollow2D/Bat
@onready var floor_raycast := $Floor_Raycast

var direction := "right"

var can_move := true
var t := 0.0
var dead := false
var is_falling := false
var is_flying := false
var add_point := true

func _ready() -> void:
	bat.visible = false
	animation.play("idle")

func _physics_process(delta: float) -> void:
	if dead == true:
		death(delta)
		if add_point == true:
			Global.boot_points += 1
			add_point = false
	if can_move == true:
		
		
		if is_falling == true:
			animation.play("fall")
			velocity.y += FALL
	
		if floor_raycast.is_colliding():
			is_falling = false
			is_flying = true
		
		if is_flying == true:
			animation.play("fly")
			velocity.y = 0
			if raycast_left2.is_colliding() or raycast_left.is_colliding():
				direction = "right"
	
			if raycast_right2.is_colliding() or raycast_right.is_colliding():
				direction = "left"
		
			if direction == "right":
				animation.flip_h = true
				velocity.x += ACCELERATION
		
			if direction == "left":
				animation.flip_h = false
				velocity.x -= ACCELERATION
		
		velocity.y = clamp(velocity.y, -MAX_FALL, MAX_FALL)
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		move_and_slide()
	

func death(delta):
	t += delta
	path.progress = t * 140
	
	if t > 1:
		queue_free()

func _on_top_area_area_entered(area: Area2D) -> void:
	if area.name == "Boots":
		top_col.set_deferred("disabled", true)
		col.set_deferred("disabled", true)
		animation.visible = false
		bat.visible = true
		can_move = false
		dead = true


func _on_detect_area_right_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_falling = true
		direction = "right"
		left_col.set_deferred("disabled", true)
		right_col.set_deferred("disabled", true)


func _on_detect_area_left_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_falling = true
		direction = "left"
		left_col.set_deferred("disabled", true)
		right_col.set_deferred("disabled", true)
		


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if direction == "right":
		direction = "left"
	elif direction == "left":
		direction = "right"
