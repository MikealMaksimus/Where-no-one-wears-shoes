extends Node3D

func _ready() -> void:
	$Door.hide()

func _on_inside_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$Door.position.y = -0.895
		$Door.show()
		$Yap.start()


func _on_yap_timeout() -> void:
		await $Door/VisibleOnScreenNotifier3D.screen_exited
		$Door.position.y += 15
		$Door.hide()
