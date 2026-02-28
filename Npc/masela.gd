extends Node3D

var shop := Vector3(-63.864, 1.55, -49.539)
var chilling = Vector3(-8.156, 0.946, 31.908)

func interact():
	$AudioStreamPlayer3D.play()
	$StaticBody3D.remove_from_group("interactable")


func _on_audio_stream_player_3d_finished() -> void:
	$StaticBody3D.add_to_group("interactable")


func _on_player_bought() -> void:
	$Choise.play()


func _on_player_poor() -> void:
	$Poor.play()


func _on_cycler_timeout() -> void:
	if Info.day == 1:
		position = shop
	elif Info.time == "dawn":
		position = shop
	else:
		position = shop
