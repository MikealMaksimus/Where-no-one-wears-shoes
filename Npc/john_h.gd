extends Node3D


func interact():
	if get_parent().name == "Hell":
		$Hell.play()
		$StaticBody3D.remove_from_group("interactable")
	else:
		$Heaven.play()
		$StaticBody3D.remove_from_group("interactable")

func _on_talk_finished() -> void:
	$StaticBody3D.add_to_group("interactable")
