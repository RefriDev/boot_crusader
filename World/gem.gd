extends Area2D

@export var gem_number := 1

@onready var animation := $AnimationPlayer
@onready var collect_sound := $Collect_Sound

func  _ready() -> void:
	animation.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.gem = true
		
		if gem_number == 1:
			Global.gem1 = true
		if gem_number == 2:
			Global.gem2 = true
		if gem_number == 3:
			Global.gem3 = true
		if gem_number == 4:
			Global.gem4 = true
		if gem_number == 5:
			Global.gem5 = true
		
		collect_sound.play()
		visible = false


func _on_collect_sound_finished() -> void:
	queue_free()
