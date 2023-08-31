extends CharacterBody2D

## Speed that the player moves at LEFT and RIGHT
@export var MAX_SPEED : int = 100

## Added velocity until player reach max_speed
@export var ACCELERATION : int = 20

## Frames before landing a JUMP that you can press JUMP in air and perfom JUMP automaticly
@export var JUMP_BUFFER_TIMER : int = 7

## Frames after falling of edge that JUMP still can be performed
@export var CAYOTETIME : int = 4

## Jump height measured in pixels
@export var JUMP_HEIGHT : int = 32

## Time it takes to reach peak of jump
@export var JUMP_TIME_TO_PEAK : float = 0.35

## Time it takes to fall down to floor after jump peak
@export var JUMP_TIME_TO_DECENT : float = 0.2

## Added velocity downwards so player jumps less heigh, part of jump buffer
@export var ADDED_FALL_VELOCITY : int = 75

@onready var jump_velocity : float = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_TO_PEAK) * -1.0 
@onready var jump_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEAK * JUMP_TIME_TO_PEAK)) * -1.0
@onready var fall_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEAK * JUMP_TIME_TO_DECENT)) * -1.0

@onready var blink := $AnimationPlayer
@onready var animation := $AnimatedSprite2D
@onready var effect_anchor := $Effect_Anchor
@onready var walk_effect := $Effect_Anchor/Walk_Effect

@export var land_effect : PackedScene

@onready var jump_sound := $Jump_Sound
@onready var hit_sound := $Hit_Sound
@onready var stomp_sound := $Stomp_Sound
@onready var start_timer := $Start_Timer
@onready var inv_timer := $Invulnerability_Timer
@onready var camera := $Camera2D

var jump_counter : int = 0
var jump_buffer_counter : int = 0
var cayote_counter : int = 0

var direction := "right"
var in_air := false
var can_move := false

var invulnerable := false
var knockback := Vector2.ZERO

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _physics_process(delta: float) -> void:
	
	if invulnerable == true:
		blink.play("blink")
	
	if can_move == true:
	
		if is_on_floor():
			
			if in_air == true:
				var effect_inst = land_effect.instantiate()
				get_parent().add_child(effect_inst)
				effect_inst.global_position = global_position
				in_air = false
	
		if direction == "right":
			effect_anchor.scale.x = 1
			animation.flip_h = false
		elif direction == "left":
			effect_anchor.scale.x = -1
			animation.flip_h = true
	
		if not is_on_floor():
			in_air = true
			animation.play("jump")
			velocity.y += get_gravity() * delta
	
		if Input.is_action_pressed("LEFT") and Input.is_action_pressed("RIGHT"):
			velocity.x = 0
	
		elif Input.is_action_pressed("RIGHT"):
			direction = "right"
			velocity.x += ACCELERATION
			if is_on_floor():
				walk_effect.play("default")
				animation.play("walk")
			else:
				walk_effect.stop()
				walk_effect.frame = 8
	
		elif Input.is_action_pressed("LEFT"):
			direction = "left"
			velocity.x -= ACCELERATION
			if is_on_floor():
				walk_effect.play("default")
				animation.play("walk")
			else:
				walk_effect.stop()
				walk_effect.frame = 8
	
		else:
			walk_effect.stop()
			walk_effect.frame = 8
			velocity.x = 0
			if is_on_floor():
				animation.play("idle")
	
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	
		if is_on_floor():
			cayote_counter = CAYOTETIME
	
		if not is_on_floor():
			if cayote_counter > 0:
				cayote_counter -= 1
	
		if Input.is_action_just_pressed("JUMP"):
			jump_buffer_counter = JUMP_BUFFER_TIMER
	
		if jump_buffer_counter > 0:
			jump_buffer_counter -= 1
	
		if jump_buffer_counter > 0 and cayote_counter > 0:
			jump_sound.play()
			velocity.y = jump_velocity
			jump_buffer_counter = 0
			cayote_counter = 0
	
		if Input.is_action_just_released("JUMP"):
			if velocity.y < 0:
				velocity.y += ADDED_FALL_VELOCITY
		
		if knockback != Vector2.ZERO:
			velocity = knockback
		
		move_and_slide()
	
func _on_start_timer_timeout() -> void:
	start_timer.stop()
	can_move = true


func _on_hitbox_body_entered(_body: Node2D) -> void:
	
	take_damage(Vector2(300,-200))

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	if invulnerable == false:
		invulnerable = true
		inv_timer.start()
		hit_sound.play()
		Global.health -= 1
		if knockback_force != Vector2.ZERO:
			knockback = knockback_force
			var knock_tween = get_tree().create_tween()
			knock_tween.tween_property(self, "knockback", Vector2.ZERO, duration)
		if Global.health <= 0:
			jump_sound.volume_db = -80
			stomp_sound.volume_db = -80
			can_move = false
			Global.dead = true
		

func _on_boots_area_entered(_area: Area2D) -> void:
	stomp_sound.play()
	velocity.y = jump_velocity


func _on_hitbox_right_body_entered(_body: Node2D) -> void:
	take_damage(Vector2(-300,-200))



func _on_invulnerability_timer_timeout() -> void:
	inv_timer.stop()
	if invulnerable == true:
		invulnerable = false
		blink.play("RESET")
		if can_move == false:
			hit_sound.volume_db = -80
