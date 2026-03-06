extends Node3D

var inside = false

func _process(_delta: float) -> void:
	var mat: ShaderMaterial = $CanvasLayer/Freeze.material as ShaderMaterial
	Info.unfreeze = 1 - mat.get_shader_parameter("freeze_amount")

func _on_inside_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and $CoolD.is_stopped():
		inside = true
		$Timer.start()

func _on_inside_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		inside = false

func _on_timer_timeout() -> void:
	if inside:
		$AnimationPlayer.play("Door")
		await get_tree().create_timer(5.5).timeout
		Info.NewDay = true
		await get_tree().create_timer(0.1).timeout
		$AnimationPlayer.play("RESET")
		$CoolD.start()
