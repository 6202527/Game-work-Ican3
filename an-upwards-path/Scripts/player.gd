extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const DASHVELOCITY = 10000
var JUMP = 2
@onready var animated_sprite = $AnimatedSprite2D
var dashNum = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#resets jump to 2 when player is on ground + resets dash when player is on ground
	if is_on_floor():
		JUMP = 2
		dashNum = 1

	# Handle jump.
	if Input.is_action_just_pressed("jump") and JUMP > 0:
		velocity.y = JUMP_VELOCITY
		JUMP -= 1

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	#play animations
	if is_on_floor:
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Adds dash movement
	if Input.is_action_just_pressed("dash") and dashNum > 0:
		dashNum -= 1
		velocity.x = direction * DASHVELOCITY

	move_and_slide()
