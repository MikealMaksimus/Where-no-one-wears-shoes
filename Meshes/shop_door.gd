extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Info.time == "day" or "dusk": #vaan day
		$Door_001/StaticBody3D/CollisionShape3D.disabled = true
		hide()
	else:
		$Door_001/StaticBody3D/CollisionShape3D.disabled = false
		show()
