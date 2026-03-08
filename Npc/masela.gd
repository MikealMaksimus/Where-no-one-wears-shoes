extends Node3D

var shopping := Vector3(-63.864, 1.55, -49.539)
var chilling := Vector3(8.294, 0.946, 29.323)
var looking := Vector3(63.006, 0.946, 57.592)

var atShop := preload("res://Voices/Hello my friend.mp3")
var morningWood := preload("res://Voices/When the sun is high.mp3")
var fried := preload("res://Voices/He was.mp3")

func _ready() -> void:
	move()

func interact():
	$AudioStreamPlayer3D.play()
	$StaticBody3D.remove_from_group("interactable")


func _on_audio_stream_player_3d_finished() -> void:
	$StaticBody3D.add_to_group("interactable")


func _on_player_bought() -> void:
	$Choise.play()


func _on_player_poor() -> void:
	$Poor.play()

func move():
	if Info.day == 1:
		position = shopping
	elif Info.time == "day":
		$AudioStreamPlayer3D.stream = atShop
		position = shopping
		rotation_degrees.y = 174.5
	elif Info.time == "dusk":
		position = looking
		rotation_degrees.y = 108.3
		$AudioStreamPlayer3D.stream = fried
	else:
		position = chilling
		rotation_degrees.y = 139.1
		$AudioStreamPlayer3D.stream = morningWood

func _on_cycler_timeout() -> void:
	move()


func _on_world_dawned() -> void:
	move()
