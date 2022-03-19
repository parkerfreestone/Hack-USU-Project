extends KinematicBody2D


const UP_DIRECTION := Vector2.UP

var SPEED = 15
var GRAVITY = 4000
var ACCELERATION = 1

var velocity = Vector2()
var moving_left = false

export var current_room = 0

func _process(delta):
	emit_signal("room_changed", current_room)

func get_input():
	velocity = Vector2()

	if moving_left:
		$Sprite.flip_h = true
	elif !moving_left:
		$Sprite.flip_h = false

	if Input.is_action_pressed("move_left"):
		velocity.x += -ACCELERATION
		moving_left = true
	if Input.is_action_pressed("move_right"):
		velocity.x += ACCELERATION
		moving_left = false

	velocity = velocity.normalized() * SPEED
	


func _physics_process(delta):

	get_input()
	
	velocity.y += delta * GRAVITY
	
	velocity = move_and_slide(velocity, UP_DIRECTION)
