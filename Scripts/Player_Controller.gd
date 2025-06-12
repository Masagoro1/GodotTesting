extends CharacterBody3D

#vars for movement
@export var speed := 5.0
@export var jump_velocity := 4.5
@export var gravity := 9.8

var isEnabled = true

#vars for camera
@export var sensitivity := 0.002

@onready var playerBody := $PlayerBody
@onready var camera := $PlayerBody/PlayerView

var yaw := 0.0
var pitch := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(isEnabled):
		#region Movement
		var direction = Vector3.ZERO

		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		if Input.is_action_pressed("move_backward"):
			direction.z += 1
		if Input.is_action_pressed("move_forward"):
			direction.z -= 1
		
		direction = direction.normalized()
		direction = direction.rotated(Vector3.UP, yaw)
		
		if not is_on_floor():
			velocity.y -= gravity * delta
		elif Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		#endregion
		

		
		move_and_slide()
	
func _unhandled_input(event):
	if(isEnabled):
		if event is InputEventMouseMotion:
			yaw -= event.relative.x * sensitivity
			pitch -= event.relative.y * sensitivity
			pitch = clamp(pitch, deg_to_rad(-89), deg_to_rad(89))
		playerBody.rotation.y = yaw
		camera.rotation.x = pitch
