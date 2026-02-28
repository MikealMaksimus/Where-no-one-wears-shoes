extends Node3D

var voice = preload("res://Voices/Come inside.mp3")

func interact():
	$qrosp.remove_from_group("interactable")
	$AudioStreamPlayer.play()
