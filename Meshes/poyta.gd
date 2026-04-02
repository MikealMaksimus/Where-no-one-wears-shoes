extends Node3D

var greetings := preload("res://qrosping/GreetingsMortal.mp3")
var sins := preload("res://qrosping/First your sins.mp3")
var eating := preload("res://qrosping/Eating my holy.mp3")
var virtues := preload("res://qrosping/And you virtues are.mp3")
var entering := preload("res://qrosping/EnteringTheForbidden.mp3")

var heaven := preload("res://qrosping/Positive.mp3")
var hell := preload("res://qrosping/Negative.mp3")

var score := -1

func interact():
	get_parent().shut()
	$qrosp.remove_from_group("interactable")
	$AudioStreamPlayer.stream = greetings
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	$AudioStreamPlayer.stream = sins
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	if Info.enterd:
		$AudioStreamPlayer.stream = entering
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished
		score -= 1
	$AudioStreamPlayer.stream = virtues
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	if Info.eaten:
		$AudioStreamPlayer.stream = eating
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished
		score += 1
	
	if score >= 0:
		$AudioStreamPlayer.stream = heaven
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished
		get_tree().change_scene_to_file("res://heaven.tscn")
	else:
		$AudioStreamPlayer.stream = hell
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished
		get_tree().change_scene_to_file("res://hell.tscn")
