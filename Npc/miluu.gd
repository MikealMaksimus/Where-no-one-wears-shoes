extends Node3D

var one := preload("res://Voices/New guy.mp3")
var two := preload("res://Voices/These nights.mp3")
var three := preload("res://Voices/Miluu finale.mp3")

func _ready() -> void:
	position = Vector3(-28.15, 1.453, -20)
	$Shovel.hide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$AudioStreamPlayer.play()
		$Hoy.queue_free()

func interact():
	line()
	
	$AudioStreamPlayer3D.play()
	$StaticBody3D.remove_from_group("interactable")

func move():
	if Info.time == "night" or Info.day >= 3:
		queue_free()
	elif Info.day == 2 and not Info.time == "dawn":
		$Shovel.show()
		position = Vector3(63.39, 0.823, -66.352)


func _on_audio_stream_player_3d_finished() -> void:
	$StaticBody3D.add_to_group("interactable")

func line():
	if Info.day == 2 and Info.time == "dawn":
		$AudioStreamPlayer3D.stream = two
		print("b")
	elif Info.day == 2:
		$AudioStreamPlayer.stream = three
		Info.money += 2
		print("a")
	else:
		print(Info.day)
		$AudioStreamPlayer3D.stream = one


func _on_cycler_timeout() -> void:
	move()


func _on_world_dawned() -> void:
	move()
