extends KinematicBody2D

signal player_hidden(hidden_value)

# CONSTANTS
const UP_DIRECTION = Vector2.UP
const ACCELERATION = 1

# VARIABLES
var velocity = Vector2()
var moving_left = false
var stamina = 100
var is_hidden = false
var can_hide = false
var speed = 15
var gravity = 4000


# HANDLE USER INPUT
func get_input():

	velocity = Vector2()

	# INCREASE STAMINA WHEN BELOW 100
	if stamina < 100:
		stamina += .5

	# HANDLE LEFT MOVEMENT (Make sure player isn't is_hidden)
	if Input.is_action_pressed("move_left") && !is_hidden:
		velocity.x += -ACCELERATION
		$Sprite.flip_h = true
		$AnimationPlayer.play("Walk")
		if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.play()

	# HANDLE RIGHT MOVEMENT (Make sure player isn't is_hidden)
	if Input.is_action_pressed("move_right") && !is_hidden:
		velocity.x += ACCELERATION
		$Sprite.flip_h = false
		$AnimationPlayer.play("Walk")
		if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.play()

	# HANDLE SPRINTING (Make sure player isn't is_hidden)
	if Input.is_action_pressed("sprint") && stamina > 17 && !is_hidden:
		speed = 30
		stamina -= 1
		if stamina < 20:
			stamina = 0
			speed = 15

	# PLAYER STOPPED SPRINTING
	if Input.is_action_just_released("sprint"):
		speed = 15

	# HANDLE HIDING
	if Input.is_action_pressed("hide") && velocity.x == 0:
		if can_hide:
			# CHANGE PLAYER PHYSICAL STATE
			$AnimationPlayer.play("Crouch")
			$Sprite.set_modulate(Color(1, 1, 1, 0.5))
			$Light2D.set_color(Color(0.39,0.36,0.67))
			$CollisionShape2D.disabled = true

			# CHANGE VARIABLES
			is_hidden = true
			speed = 0
			gravity = 0

			# TELL ENEMY THAT PLAYER IS HIDDEN
			emit_signal("player_hidden", is_hidden)

	if Input.is_action_just_released("hide"):
		# CHANGE PLAYER PHYSICAL STATE
		$CollisionShape2D.disabled = false
		$Sprite.set_modulate(Color(1, 1, 1, 1))

		# CHANGE VARIABLES
		is_hidden = false
		speed = 15
		gravity = 4000

		# TELL ENEMY THAT PLAYER IS HIDDEN
		emit_signal("player_hidden", is_hidden)

	# CHANGE ANIMATION STATE DEPENDING ON X VELOCITY
	if velocity.x == 0:
		if $AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stop()
		if !is_hidden:
			$AnimationPlayer.play("Idle")
		elif is_hidden:
			$AnimationPlayer.play("Crouch")

	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta

	velocity = move_and_slide(velocity, UP_DIRECTION)
