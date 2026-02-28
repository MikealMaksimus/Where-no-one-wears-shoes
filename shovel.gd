extends RigidBody3D

var shadow := true
var price := 1
var durability := 3

func _ready():
	var cylinder := $Shovel/Cylinder

	var mat0 = cylinder.get_active_material(0)
	var mat1 = cylinder.get_active_material(1)

	if mat0:
		cylinder.set_surface_override_material(0, mat0.duplicate())

	if mat1:
		cylinder.set_surface_override_material(1, mat1.duplicate())


func _process(_delta: float) -> void:
	var cylinder := $Shovel/Cylinder

	cylinder.cast_shadow = shadow
	$Shovel/Cylinder_001.cast_shadow = shadow

	var mat0 := cylinder.get_surface_override_material(0) as StandardMaterial3D
	var mat1 := cylinder.get_surface_override_material(1) as StandardMaterial3D

	if mat0 and mat1:
		mat0.use_z_clip_scale = not shadow
		mat1.use_z_clip_scale = not shadow

	if not shadow:
		Info.dig = true
