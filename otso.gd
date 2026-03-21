extends Node3D

var blasphemy := preload("res://Voices/BlasphemousT.mp3")
var blessing := preload("res://Voices/Blessings T.mp3")
var church := preload("res://Voices/This is the church.mp3")
var treat := preload("res://Voices/for a price.mp3")
var open := preload("res://Voices/Open Wide!!!!.mp3")
var broke := preload("res://Voices/broke.mp3")

var second := false
var selling := false

signal tripping

func interact():
	
	if Info.time == "night":
		return
	
	$StaticBody3D.remove_from_group("interactable")
	if not second:
		$AudioStreamPlayer3D.stream = church
		second = true
		$AudioStreamPlayer3D.play()
	elif not selling:
		$AudioStreamPlayer3D.stream = treat
		selling = true
		$StaticBody3D.add_to_group("selling")
		$AudioStreamPlayer3D.play()
	elif Info.money >= 1:
		$AudioStreamPlayer3D.stream = open
		selling = false
		Info.eaten = true
		Info.money -= 1
		$AudioStreamPlayer3D.play()
		await $AudioStreamPlayer3D.finished
		emit_signal("tripping")
	else:
		$AudioStreamPlayer3D.stream = broke
		$AudioStreamPlayer3D.play()

func _on_shop_body_entered(body: Node3D) -> void:
	if Info.time == "night":
		$AudioStreamPlayer3D.stream = blasphemy
	else:
		$AudioStreamPlayer3D.stream = blessing
	
	$AudioStreamPlayer3D.play()
	


func _on_audio_stream_player_3d_finished() -> void:
	$StaticBody3D.add_to_group("interactable")


func _on_world_dawned() -> void:
	if Info.day >= 6:
		queue_free()
