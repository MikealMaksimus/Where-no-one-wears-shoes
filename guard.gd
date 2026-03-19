extends Node3D

var second := false
var ncs := preload("res://Sounds/You don't belong.mp3")

func _ready() -> void:
	hide()
	position.y = -1.332

func interact():
	$StaticBody3D.remove_from_group("interactable")
	if second:
		$AudioStreamPlayer3D.stream = ncs
	$AudioStreamPlayer3D.play()
	second = true


func _on_world_dawned() -> void:
	if Info.day >= 7:
		queue_free()
	
	show()
	position.y = 1.332


func _on_cycler_timeout() -> void:
	if Info.time == "night":
		hide()
		position.y = -1.332


func _on_audio_stream_player_3d_finished() -> void:
	$StaticBody3D.add_to_group("interactable")
