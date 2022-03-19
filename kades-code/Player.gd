extends KinematicBody2D

const UP_DIRECTION = Vector2.UP

var SPEED = 15
var GRAVITY = 4000
var ACCELERATION = 1

var velocity = Vector2()
var moving_left = false

export var current_room = 0

func get_input():
	if stamina < 100:
		stamina += .5
	velocity = Vector2()

	print(stamina)

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
<<<<<<< HEAD
		$AnimationPlayer.play("Walk")
	if Input.is_action_pressed("sprint") && stamina > 17:
		SPEED = 60
		stamina -= 1
		if stamina < 20:
			stamina = 0;
			SPEED = 15
	
	if Input.is_action_just_released("sprint"):
		SPEED = 15

	if Input.is_action_pressed("hide"):
		hidden = true
		$AnimationPlayer.play("Hide")
	
	if velocity.x == 0:
		if !hidden:
			$AnimationPlayer.play("Idle")
		elif hidden:
			$AnimationPlayer.play("Hide")
=======
>>>>>>> 61262148a778c38e5106dc06042e9fee7a4ef1f3

	velocity = velocity.normalized() * SPEED
	


func _physics_process(delta):

	get_input()
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity, UP_DIRECTION)
