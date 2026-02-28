extends Node3D


func interact():
	$AudioStreamPlayer3D.play()
	$StaticBody3D.remove_from_group("interactable")


func _on_audio_stream_player_3d_finished() -> void:
	$StaticBody3D.add_to_group("interactable")


func _on_player_bought() -> void:
	$Choise.play()


func _on_player_poor() -> void:
	$Poor.play()
