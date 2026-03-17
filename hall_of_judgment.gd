extends Node3D

func _ready() -> void:
	Info.unfreeze = 1


func _on_audio_stream_player_finished() -> void:
	$chanter.stream = load("res://Sounds/qrospChant.mp3")
	$chanter.play()
