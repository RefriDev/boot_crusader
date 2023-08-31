extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if Global.gem == true:
			if Global.lvl_on == 1:
				Global.gem1 = true
			if Global.lvl_on == 2:
				Global.gem2 = true
			if Global.lvl_on == 3:
				Global.gem3 = true
			if Global.lvl_on == 4:
				Global.gem4 = true
			if Global.lvl_on == 5:
				Global.gem5 = true
		
		Global.start_boot_points = Global.boot_points
		
		Global.lvl_completed[Global.lvl_on-1] = true
		Global.lvl_on += 1
			
		get_tree().change_scene_to_file("res://Scenes/map/new_map.tscn")
