extends Node

var new_game := true

var dead := false
var health := 3
var gem := false

var gems := 0

var gem1 := false
var gem2 := false
var gem3 := false
var gem4 := false
var gem5 := false

var start_boot_points := 0
var boot_points := 0
var boss_boot_points := 0

var lvl_on := 1

var lvl_completed := [false, false, false, false, false]

var round := false

func _process(delta: float) -> void:
	if lvl_on == 5:
		if boot_points >= boss_boot_points + 4:
			#print("here")
			round = true
		

