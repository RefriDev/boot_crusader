extends Control

@onready var start_text := $Start
@onready var animation := $AnimationPlayer
@onready var empty_hearts := $HP/Empty_Hearts
@onready var full_hearts := $HP/Full_Hearts
@onready var gem := $Gem/Full_Gem
@onready var boot_number := $Kills/Numbers

var heart_size := 12

func _ready() -> void:
	gem.visible = false
	animation.play("start")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "start":
		start_text.visible = false

func _process(_delta: float) -> void:
	
	full_hearts.size.x = heart_size * Global.health
	
	if Global.health == 0:
		full_hearts.scale.x = 0
	
	if Global.gem == true:
		gem.visible = true
	
	if Global.boot_points <= 9:
		boot_number.text = "00" + str(Global.boot_points)
	elif Global.boot_points >= 9 and Global.boot_points <= 99:
		boot_number.text = "0" + str(Global.boot_points)
	else:
		boot_number.text = str(Global.boot_points)
