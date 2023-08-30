extends CharacterBody2D

@export var MAX_SPEED : int = 100
@export var ACCELERATION : int = 20

@onready var animation := $AnimatedSprite2D
@onready var raycast_left := $RayCast2D_Left
@onready var raycast_right := $RayCast2D_Right
@onready var top_col := $Top_Area/CollisionShape2D
@onready var col := $CollisionShape2D
@onready var path := $Path2D/PathFollow2D
@onready var spider := $Path2D/PathFollow2D/Spider

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var direction := "right"

var can_move := false
var t := 0.0
var dead := false
var add_point := true

func _ready() -> void:
	spider.visible = false
	animation.play("walk")

func _physics_process(delta: float) -> void:
	if dead == true:
		death(delta)
		if add_point == true:
			Global.boot_points += 1
			add_point = false

	if can_move == true:
		
		if not is_on_floor():
			velocity.y += gravity * delta
	
		if not raycast_left.is_colliding():
			direction = "right"
	
		if not raycast_right.is_colliding():
			direction = "left"
	
		if direction == "right":
			animation.flip_h = false
			velocity.x += ACCELERATION
	
		elif direction == "left":
			animation.flip_h = true
			velocity.x -= ACCELERATION
		
	
		
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	
		move_and_slide()

func _on_top_area_area_entered(area: Area2D) -> void:
	if area.name == "Boots":
		top_col.set_deferred("disabled", true)
		col.set_deferred("disabled", true)
		animation.visible = false
		spider.visible = true
		can_move = false
		dead = true
		


func _on_activate_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		can_move = true


func _on_activate_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		can_move = false

func death(delta):
	t += delta
	path.progress = t * 140
	
	if t > 1:
		queue_free()
