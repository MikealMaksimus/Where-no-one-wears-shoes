extends Node3D

func _ready() -> void:
	$Door.hide()

func _on_inside_body_entered(body: Node3D) -> void:
	if not body.is_in_group("player"):
		return
	
	if Info.moons < 4:
		$Door.position.y = -0.895
		$Door.show()
		await get_tree().create_timer(0.3).timeout
		$AudioStreamPlayer.play()
	else:
		$Door.position.y = -0.895
		$Door.show()
		await get_tree().create_timer(0.3).timeout
		$AudioStreamPlayer2.play()
		Info.immortality = true

func _on_audio_stream_player_finished() -> void:
		await $Door/VisibleOnScreenNotifier3D.screen_exited
		$Door.position.y += 15
		$Door.hide()
