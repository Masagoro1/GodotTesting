extends Node

var Player2D
var Player3D
var cam2D
var cam3D

var enable2D = false


func _ready():
	cam2D = get_node("/root/TestScene/Camera2D")
	cam3D = get_node("/root/TestScene/Player3D/PlayerBody/PlayerView")
	Player2D = get_node("/root/TestScene/Player2D")
	Player3D = get_node("/root/TestScene/Player3D")
	print(Player2D)
	print(Player3D)
	print(cam2D)


func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		switchPlayer()

func switchPlayer():
	enable2D = !enable2D
	Player2D.isEnabled = enable2D
	Player3D.isEnabled = !enable2D
	if enable2D:
		cam2D.set_current(true)
	else:
		cam3D.set_current(true)

