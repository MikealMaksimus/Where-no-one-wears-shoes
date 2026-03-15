extends Node3D

func interact():
	$AudioStreamPlayer3D.play()



func _on_world_dawned() -> void:
	show()
	position.y = 1.332


func _on_cycler_timeout() -> void:
	if Info.time == "night":
		hide()
		position.y = -1.332
