extends  Node3D

var held = null

func _ready() -> void:
	$CanvasLayer/E.hide()

func _process(_delta: float) -> void:
	
	var object = $Camera3D/RayCast3D2.get_collider()
	spaghethos()
	#extreme spagethi
	if not object == null:
		if object.is_in_group("buyable"):
			$CanvasLayer/E.show()
			$CanvasLayer/E.text = "Buy " + str(object.price) + "₮"
		elif object.is_in_group("pickable"):
			$CanvasLayer/E.show()
			$CanvasLayer/E.text = "Pick up"
		elif object.is_in_group("selling"):
			$CanvasLayer/E.show()
			$CanvasLayer/E.text = "buy 1₮"
		elif object.is_in_group("interactable"):
			$CanvasLayer/E.show()
			$CanvasLayer/E.text = "Interact"
		else:
			$CanvasLayer/E.hide()
	else:
		$CanvasLayer/E.hide()
		return
	
	if $Camera3D/RayCast3D2.is_colliding() and object.is_in_group("buyable") and Input.is_action_just_pressed("interact"):
		if object.price <= Info.money:
			get_parent().emit_signal("bought")
		else:
			get_parent().emit_signal("poor")
	
	if $Camera3D/RayCast3D2.is_colliding() and object.is_in_group("pickable") and Input.is_action_just_pressed("interact") and object.price <= Info.money:
			held = object
			held.shadow = false
			if object.is_in_group("buyable"): #The holy nest
				object.remove_from_group("buyable")
				Info.money -= object.price
				object.price = 0
	
	elif $Camera3D/RayCast3D2.is_colliding() and object.is_in_group("interactable") and Input.is_action_just_pressed("interact"):
		object.get_parent().interact()
		
	elif $Camera3D/RayCast3D2.is_colliding() and object.is_in_group("consumable") and Input.is_action_just_pressed("interact") and object.price <= Info.money:
		object.consume()

func spaghethos():
	if not held == null:
		held.global_position = $Hand.global_position
		held.global_rotation_degrees = $Hand.global_rotation_degrees
		held.collision_layer = 2

	if Input.is_action_just_pressed("drop") and held:
		held.shadow = true
		held = null
		Info.dig = false
	
func mammaMia():
	held.durability -= 1
	if held.durability <= 0:
		$AudioStreamPlayer.play()
		held.shadow = true
		held.queue_free()
		held = null
		Info.dig = false
