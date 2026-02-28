extends CanvasLayer


func dawn():
	if Info.day == 8:
		get_tree().change_scene_to_file("res://hall_of_judgment.tscn")
	else:
		$Time.play("Dawn")
		$Node2D/Label.text = mornin()
		Info.cycling = true

func mornin():
	if Info.day == 1:
		return "Rise and shine"
	elif Info.day == 2:
		return "Up you go, young one"
	elif Info.day == 3:
		return "Make it count"
	elif Info.day == 4:
		return "The house feels still"
	elif Info.day == 5:
		return "The days are catching up"
	elif Info.day == 6:
		return "Easy there, old man."
	elif Info.day == 7:
		return "today might be the last"

func day():
	$Time.play("Day")
	Info.cycling = true

func dusk():
	$Time.play("Dusk")
	Info.cycling = true

func night():
	$Time.play("Night")
	Info.cycling = true


func _on_time_animation_finished(anim_name: StringName) -> void:
	if Info.day <= 8:
		Info.cycling = false
