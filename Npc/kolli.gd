extends Node3D

var house := Vector3(-106, 0.646, -38.0)
var tree := Vector3(101.263, 0.646, -99.679) 
var forest := Vector3(57.641, 0.646, 99.332)  
var hidden := Vector3(-92.617, 3.065, -38.0)

func interact():
	$AudioStreamPlayer3D.play()


func _on_cycler_timeout() -> void:
	if Info.day == 2 or Info.day > 5:
		position = hidden
	elif Info.time == "day":
		position = forest
		rotation_degrees.y = 20.1
	elif Info.time == "dusk":
		position = house
		rotation_degrees.y = -80.4


func _on_world_dawned() -> void:
		if Info.day >= 5:
			queue_free()
		
		
		position = tree
		rotation_degrees.y = -168.2
