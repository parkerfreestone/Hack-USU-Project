extends KinematicBody2D

# CONSTANTS
const UP_DIRECTION = Vector2.UP
const SPEED = 20
const WANDERING_SPEED = 12
const GRAVITY = 4500.0
const ACCELERATION = 1

# VARIBALES
var random = RandomNumberGenerator.new()
var walking_time = 0

var velocity = Vector2.ZERO
var myself = null

var enemy_current_room = 0
var players_room = 0
var random_wander = 0

func _ready():
	random.randomize()


func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if walking_time >= abs(random_wander):
		random_wander = random.randi_range(-WANDERING_SPEED, WANDERING_SPEED)
		walking_time = 0

	if myself:
		velocity = position.direction_to(myself.position) * SPEED
	else:
		walking_time += ACCELERATION
		if random_wander > 0:
			velocity.x += ACCELERATION
		if random_wander < 0:
			velocity.x += -ACCELERATION

		# else:
		# 	break
		print(random_wander)
		
	move_and_slide(velocity)
		

func _on_Area2D_body_entered(body:Node):
	myself = body

func _on_Area2D_body_exited(body:Node):
	myself = null
