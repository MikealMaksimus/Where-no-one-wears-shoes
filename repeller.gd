extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Info.repelPoint = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	rotation_degrees.y += 30 * delta
	
	if $VisibleOnScreenNotifier3D.is_on_screen():
		Info.repel = true
	else:
		Info.repel = false
