extends MeshInstance3D

var inside = false
var height := -2.1



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and not $AudioStreamPlayer.playing and not inside and Info.playerPos.y >= height:
		$AudioStreamPlayer.play()
		inside = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and inside and Info.playerPos.y >= height:
		$AudioStreamPlayer.play()
		inside = false
