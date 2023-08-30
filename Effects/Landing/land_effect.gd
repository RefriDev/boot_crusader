extends Node2D



@onready var effect_left := $Effects_Left
@onready var effect_right := $Effects_Right

func _ready() -> void:
	effect_left.play("landing")
	effect_right.play("landing")

func _on_effects_left_animation_finished() -> void:
	queue_free()
