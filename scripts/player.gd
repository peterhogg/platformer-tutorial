extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var falling: bool = false;
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer: Timer = $Timer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if not falling && timer.get_time_left() == 0: 
			timer.start()

	else:
		falling = false
		timer.stop()
		
	if falling:
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and !falling:
		timer.stop()
		falling = true
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if(not falling):
		if(direction == 0):
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_timer_timeout() -> void:
	falling = true;
