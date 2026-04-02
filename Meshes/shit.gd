extends Node3D

var player : Node3D
var inside := false

func _ready() -> void:
	$Door.hide()
	$Gussi.hide()

func _on_inside_body_entered(body: Node3D) -> void:
	if not body.is_in_group("player"):
		return
	inside = true
	player = body


func _on_audio_stream_player_finished() -> void:
		$AnimationPlayer.stop()
		await $VisibleOnScreenNotifier3D.screen_exited
		$Door.position.y += 15
		$Door.hide()
		$Gussi.hide()


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	if not inside:
		return
	inside = false
	Info.enterd = true
	$AnimationPlayer.play("new_animation")
	if Info.moons < 4:
		$Door.position.y = -0.895
		$Door.show()
		$Gussi.show()
		await get_tree().create_timer(0.3).timeout
		$AudioStreamPlayer.play()
		player.subtitles()
	else:
		$Door.position.y = -0.895
		$Door.show()
		$Gussi.show()
		await get_tree().create_timer(0.3).timeout
		$AudioStreamPlayer2.play()
		Info.immortality = true


func _on_inside_body_exited(body: Node3D) -> void:
	if body == player:
		inside = false
