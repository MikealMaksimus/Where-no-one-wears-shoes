extends WorldEnvironment

var tripping := false
var whitdraw := false

func _ready() -> void:
	environment.adjustment_brightness = 1
	environment.adjustment_contrast = 2.5
	environment.adjustment_saturation = 1

func _process(delta: float) -> void:
	if whitdraw:
		environment.adjustment_brightness = 0.7
		environment.adjustment_contrast = 1.0
		environment.adjustment_saturation = 0.4
	elif tripping:
		environment.adjustment_brightness = 0.6
		environment.adjustment_contrast = 6
		environment.adjustment_saturation = 8

func _on_otso_tripping() -> void:
	whitdraw = false
	tripping = true


func _on_world_dawned() -> void:
	if tripping:
		whitdraw = true
