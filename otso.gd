extends Node3D

var blasphemy = preload("res://Voices/BlasphemousT.mp3")
var blessing = preload("res://Voices/Blessings T.mp3")
var church = preload("res://Voices/This is the church.mp3")

func interact():
	$AudioStreamPlayer3D.stream = church
	$AudioStreamPlayer3D.play()

func _on_shop_body_entered(body: Node3D) -> void:
	if Info.time == "night":
		$AudioStreamPlayer3D.stream = blasphemy
	else:
		$AudioStreamPlayer3D.stream = blessing
	
	$AudioStreamPlayer3D.play()
	
