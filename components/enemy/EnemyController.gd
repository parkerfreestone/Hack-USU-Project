extends KinematicBody2D

# CONSTANTS
const UP_DIRECTION = Vector2(0, -1)
const SPEED = 50
const GRAVITY = 4000
const WANDERING_SPEED = 12
const ACCELERATION = 1

# VARIBALES
var velocity = Vector2()
var player = null
var facing_left = false
var wander_state = 0
var player_hidden = false

# RUNS EVERY FRAME
func _physics_process(delta):
	# player IS THE NODE INTERACTING WITH THE ENEMY'S AREA 2D (IN OUR CASE THE PLAYER)
	if player && !player_hidden:
		velocity = position.direction_to(player.position) * SPEED
		player.get_child(2).set_color(Color(0.8,0.1,0.2))
		$AnimationPlayer.play("Running")

	# RUNS IF THE PLAYER ISN'T COLLIDING WITH THE ENEMY
	elif !player || player && player_hidden:
		# WANDER STATE JUST MEANS LEFT, RIGHT, OR STAY STILL
		if wander_state == 2:
			velocity.x = 0
		elif wander_state < 2:

			# SET VELOCITY AND ANIMATION
			velocity.x = WANDERING_SPEED
			$AnimationPlayer.play("Walking")

			# FLIP SPRITE AND COLLIDER
			$Sprite.flip_h = true
			$Area2D/CollisionShape2D.position.x = 136
		elif wander_state > 2:

			# SET VELOCITY AND ANIMATION
			velocity.x = -WANDERING_SPEED
			$AnimationPlayer.play("Walking")

			# FLIP SPRITE AND COLLIDER
			$Sprite.flip_h = false
			$Area2D/CollisionShape2D.position.x = -110
	
	# GIVE OUR ENEMY GRAVITY
	velocity.y += GRAVITY * delta

	# ACTUALLY MOVE OUR ENEMY (Remove velocity re-assignemnt if it doesn't work btw)
	velocity = move_and_slide(velocity, UP_DIRECTION)
		

# IS SOMETHING COLLIDING WITH OUR ENEMY?
func _on_Area2D_body_entered(body:Node):
	if body.name == "Player":
		player = body

# DID SOMETHING STOP COLLIDING WITH OUR ENEMY?
func _on_Area2D_body_exited(body:Node):
	if body.name == "Player":
		player = null

# SETS THE WANDER TIME OF OUR ENEMY
func _on_Timer_timeout():
	wander_state = floor(rand_range(0, 5))


func _on_Player_player_hidden(hidden_value):
	player_hidden = hidden_value
