extends Node3D

func interact():
	Info.key = true
	position.y -= 1000
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.8).timeout
	queue_free()
