extends Control

@onready var label = $Label

func _process(delta: float) -> void:
	label.text = "COLLECTED " + str(Global.gems) + " OF 5" 


func _on_timer_timeout() -> void:
	Global.dead = false
	if Global.gem == true:
		Global.gem = false
		Global.gems = 0
	
	Global.round = false
	Global.health = 3
	Global.boot_points = Global.start_boot_points
	get_tree().change_scene_to_file("res://Scenes/TitleScreen/title_screen.tscn")
