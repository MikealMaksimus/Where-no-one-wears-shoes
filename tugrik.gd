extends Node3D


func interact():
	Info.money += 1
	position.y -= 1000
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.8).timeout
	queue_free()
