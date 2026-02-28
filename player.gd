extends CharacterBody3D

const sensitivty := 0.15

var headBob_frecuency := 2
var headBob_aplitude := 0.1
var headBob_time := 0.0

var footstep_can_play := true
var footstep_landed

var not_flooring = false

const radius := 25
const power := 20

var force := Vector3(0, 0, 0)
var movement := Vector3(0, 0, 0)
var falling := Vector3(0, 0, 0)

signal bought
signal poor

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if not Info.cycling and event is InputEventMouseMotion:
		head(event)

func head(event):
		rotate_y(deg_to_rad(-event.relative.x * sensitivty * Info.unfreeze))
		$Head.rotate_x(deg_to_rad(-event.relative.y * sensitivty * Info.unfreeze))
		$Head.rotation.x = clamp(
			$Head.rotation.x,
			deg_to_rad(-90),
			deg_to_rad(90)
		)

func _physics_process(delta: float) -> void:
	Info.playerPos = global_position
	
	repulse(delta)
	
	
	
	if not is_on_floor():
		telespurt()
		if velocity.y >= -150:
			falling += get_gravity() * 2 * delta
		if $Blower.volume_db <= 5:
			$Blower.volume_db += 0.1
		if not $Blower.playing:
			$Blower.play()
		
	else:
		$Blower.stop()
		$Blower.volume_db = -30
		falling = Vector3.ZERO
		if not_flooring:
			$GroundSlammer.play()
			not_flooring = false
	
	if not Info.cycling:
		move()
		
	velocity = movement + force + falling
	
	move_and_slide()
	if not velocity == Vector3.ZERO and is_on_floor():
		headBob_time += delta * velocity.length() * float(is_on_floor())
		$Head/Camera3D.transform.origin = headbob(headBob_time)
	
		if not footstep_landed and is_on_floor():
			walkSound()
		elif footstep_landed and not is_on_floor():
			walkSound()
		footstep_landed = is_on_floor()

func move():
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		movement.x = direction.x * Info.speed
		movement.z = direction.z * Info.speed
	else:
		movement.x = move_toward(movement.x, 0, Info.speed)
		movement.z = move_toward(movement.z, 0, Info.speed)

func headbob(time):
	
	var headbob_position = Vector3.ZERO
	headbob_position.y = sin(time * headBob_frecuency) * headBob_aplitude
	headbob_position.x = cos(time * headBob_frecuency / 2) * headBob_aplitude
	
	var footstep_treshold = -headBob_aplitude + 0.002
	if headbob_position.y > footstep_treshold:
		footstep_can_play = true
	elif headbob_position.y < footstep_treshold:
		footstep_can_play = false
		walkSound()
	return headbob_position

func telespurt():
	if position.y <= -800:
		position.y += 1600
		get_parent().fall()
		not_flooring = true

func walkSound():
	if $RayCast3D.is_colliding():
		if $RayCast3D.get_collider().is_in_group("grassy"):
			$Grass.play()
		elif $RayCast3D.get_collider().is_in_group("cobble"):
			$Coble.play()

func repulse(delta):
	var target_force: Vector3 = Vector3.ZERO
	
	var dir = global_position - Info.repelPoint
	var distance = dir.length()

	if Info.repel and distance < radius and distance > 0.001:
		dir = dir.normalized()
		var strength = power * (1.0 - distance / radius)  # linear falloff
		target_force = dir * strength
	else:
		force = Vector3.ZERO

	# Smoothly approach target force
	var buildup_speed = 0.8  # slower buildup
	force = force.lerp(target_force, buildup_speed * delta)

func durability():
	$Head.mammaMia()
