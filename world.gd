extends Node3D

var time = 0

var night := preload("res://Tres/Night.tres")
var day := preload("res://Tres/Day.tres")
var dawn := preload("res://Tres/Dawn.tres")
var dusk := preload("res://Tres/Dusk.tres")

signal dawned

var shopping := false

func _ready() -> void:
	Goster.load_game()
	if Info.opend:
		print("close")
	else:
		print("open")
		Goster.open(true)
	
	$WorldEnvironment.environment = dusk
	$DirectionalLight3D.light_energy = 1
	$DirectionalLight3D.rotation_degrees.x = -15.0

func  _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("skip"):
		$Cycler.wait_time = 7
		$Cycler.start()
	
	if Info.NewDay:
		Info.NewDay = false
		Info.day += 1
		dawner()
		$Cycler.wait_time = 150 - Info.day * 10

func _on_cycler_timeout() -> void:
	if time == 0:
		dayer()
		time = 1
	elif time == 1:
		dusker()
		time = 2
	elif time == 2:
		nighter()
		time = 3

func dusker():
	Info.time = "dusk"
	$WorldEnvironment.environment = dusk
	$DirectionalLight3D.light_energy = 1
	$Cycled.dusk()
	$DirectionalLight3D.rotation_degrees.x = -15.0
	
	if shopping:
		$Player.global_position = $Plane/Marker3D.global_position

func dayer():
	Info.time = "day"
	$WorldEnvironment.environment = day
	$DirectionalLight3D.light_energy = 1
	$Cycled.day()
	$DirectionalLight3D.rotation_degrees.x = 216

func nighter():
	Info.time = "night"
	$WorldEnvironment.environment = night
	$DirectionalLight3D.light_energy = 0.25
	$Cycled.night()
	$DirectionalLight3D.rotation_degrees.x = -67.0

func dawner():
	Info.time = "dawn"
	emit_signal("dawned")
	$Cycler.start()
	$WorldEnvironment.environment = dawn
	$DirectionalLight3D.light_energy = 0.5
	$Cycled.dawn()
	$DirectionalLight3D.rotation_degrees.x = 200


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		$Cycler.start()
		nighter()
		$Plane/FirstNight.queue_free()

func fall():
	$Plane.rotation_degrees.y += 180
	$Plane/Node3D/Repeller._ready()

func spaghatiBologens():
	$Player.durability()


func _on_shop_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		shopping = true


func _on_shop_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		shopping = false
