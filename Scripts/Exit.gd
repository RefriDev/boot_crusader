extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.lvl_on += 1
		get_tree().change_scene_to_file("res://Scenes/map/new_map.tscn")