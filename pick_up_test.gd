extends RigidBody3D

var shadow := true
var price = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$MeshInstance3D.cast_shadow = shadow
	if not shadow:
		$MeshInstance3D.get_active_material(0).use_z_clip_scale =  true
	else:
		$MeshInstance3D.get_active_material(0).use_z_clip_scale =  false
