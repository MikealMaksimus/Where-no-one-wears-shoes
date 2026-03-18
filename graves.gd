extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Tomb41.hide()
	$dirt2.hide()


func _on_cycler_timeout() -> void:
	if Info.day == 2:
		if Info.time == "night":
			$Tomb41.show()
			$dirt2.hide()
		elif Info.time == "day":
			$dirt2.show()
	elif Info.day >= 3:
		$Tomb41.show()
		$dirt2.hide()


func _on_world_dawned() -> void:
	if Info.day >= 5:
		$Tomb42.show()
	elif Info.day >= 6:
		$Tomb43.show()
	elif Info.day >= 7:
		$Tomb44.show()
		$Tomb45.show()
