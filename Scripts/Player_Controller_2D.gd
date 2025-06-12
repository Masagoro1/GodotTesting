extends CharacterBody3D

#vars for movement
@export var speed := 5.0
@export var jump_velocity := 4.5
@export var gravity := 9.8

var isEnabled = false

func _physics_process(delta):
	if(isEnabled):
	
		var direction = Vector3.ZERO

		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		
		if not is_on_floor():
			velocity.y -= gravity * delta
		elif Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
		
		velocity.x = direction.x * speed
		
		move_and_slide()
