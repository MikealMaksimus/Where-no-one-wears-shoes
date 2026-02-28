extends Node3D

var dug = false

@onready var key = preload("res://Meshes/key.tscn")

func _ready() -> void:
	$dirt.rotation_degrees = -rotation_degrees
	$dirt.hide()
	$dirt.global_position.y = 0.01

func _process(_delta: float) -> void:
	if Info.dig and not dug:
		$StaticBody3D.add_to_group("interactable")
	else:
		$StaticBody3D.remove_from_group("interactable")


func interact():
	dug = true
	$AudioStreamPlayer.play()
	$dirt.show()
	get_parent().get_parent().get_parent().spaghatiBologens()
	if is_in_group("TheTomb"):
		var k = key.instantiate()
		add_child(k)
		k.position.x = -0.8
		k.position.y = -0.325
