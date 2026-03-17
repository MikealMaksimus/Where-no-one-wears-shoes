extends Node3D

var price := 2

func consume():
	Info.speed += 1.5
	position.y -= 1000
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.8).timeout
	queue_free()
