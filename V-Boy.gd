extends CharacterBody2D

@export var move_speed = 220

@export var jump_height = 100
@export var jump_time_to_peak = 0.40
@export var jump_time_to_descent = 0.35

@onready var jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@onready var walljump_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent * -5.0)) * 1-0
const wall_jump_pushback = 1000
const wall_slide_speed = 1

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCast2D_right
@onready var ray_cast_left = $RayCast2D_left

var double_jump_buff = false
var jump_counter = 1

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	velocity.y += get_gravity() * delta
	velocity.x = get_input_velocity() * move_speed
	
	if is_on_floor():
		jump_counter = 1
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
		
	if not is_on_floor():
		if ray_cast_right.is_colliding() or ray_cast_left.is_colliding():
			animated_sprite.play("wall_jump")
			if velocity.y > 0:
				get_gravity()
			if Input.is_action_just_pressed("jump"):
				wall_jump()
		if not (ray_cast_right.is_colliding() or ray_cast_left.is_colliding()) and velocity.y > 0:
			animated_sprite.play("fall")
		elif not (ray_cast_right.is_colliding() or ray_cast_left.is_colliding()) and velocity.y < 0:
			animated_sprite.play("jump")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animated_sprite.play("jump")
		jump()
		
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		if jump_counter < 1:
			jump_counter += 1
			double_jump()
		
	move_and_slide()
	
func get_gravity():
	if (ray_cast_right.is_colliding() or ray_cast_left.is_colliding()) and velocity.y > 0:
		return walljump_gravity
	else:
		return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func jump():
	velocity.y = jump_velocity
	
func double_jump():
	velocity.y = jump_velocity * 0.8
	
func wall_jump():
	if Input.is_action_pressed("move_right"):
		velocity.x = -wall_jump_pushback
		velocity.y = jump_velocity * 0.6
	elif Input.is_action_pressed("move_left"):
		velocity.x = wall_jump_pushback
		velocity.y = jump_velocity * 0.6
	var acceleration = 100
	var target_velocity = Vector2.ZERO
	
	var acceleration_vector = (target_velocity - velocity).normalized() * acceleration * get_process_delta_time()
	velocity += acceleration_vector
	
	velocity.x = clamp(velocity.x, -wall_jump_pushback, wall_jump_pushback)
	
	move_and_slide()
		
	
func get_input_velocity():
	var horizontal = 0.0
	
	if Input.is_action_pressed("move_left"):
		horizontal = -1.0
	if Input.is_action_pressed("move_right"):
		horizontal = 1.0
		
	return horizontal
