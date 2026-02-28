extends Node3D


func interact():
	if Info.key:
		$AnimationPlayer.play("Open")
		$StaticBody3D.remove_from_group("interactable")
	else:
		$knock.play()
