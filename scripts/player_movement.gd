extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const PUSH_SPEED = 300

var touched_floor
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		touched_floor = true
	# Handle jump.
	if Input.is_action_pressed("Up") and touched_floor:
		velocity.y = JUMP_VELOCITY
		touched_floor = false
	elif not Input.is_action_pressed("Up"):
		velocity.y += 30
		
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		position.x += direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().get_class() == "RigidBody2D":
			var collider = collision.get_collider()
			if collision.get_normal().y != -1:
				collider.linear_velocity = collision.get_normal()*-1*PUSH_SPEED
				
	move_and_slide()
