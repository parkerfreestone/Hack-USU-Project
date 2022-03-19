extends KinematicBody2D

# CONSTANTS
const UP_DIRECTION = Vector2(0, -1)
const SPEED = 50
const WANDERING_SPEED = 12
const ACCELERATION = 1

# VARIBALES
var velocity = Vector2()
var myself = null
var facing_left = false

var enemy_current_room = 0
var players_room = 0
var wander_state = 0


func _physics_process(delta):

	if facing_left:
		$Sprite.flip_h = true
	elif !facing_left:
		$Sprite.flip_h = false

	if myself:
		velocity = position.direction_to(myself.position) * SPEED
		$AnimationPlayer.play("Running")
	elif !myself:
		if wander_state == 2:
			velocity.x = 0
		elif wander_state < 2:
			velocity.x = WANDERING_SPEED
			$AnimationPlayer.play("Walking")
			facing_left = true
			$Area2D/CollisionShape2D.position.x = 87
		elif wander_state > 2:
			velocity.x = -WANDERING_SPEED
			$AnimationPlayer.play("Walking")
			facing_left = false
			$Area2D/CollisionShape2D.position.x = -65
			
		
	move_and_slide(velocity, UP_DIRECTION)
		

func _on_Area2D_body_entered(body:Node):
	if body.name == "Player":
		myself = body

func _on_Area2D_body_exited(body:Node):
	if body.name == "Player":
		myself = null


func _on_Timer_timeout():
	wander_state = floor(rand_range(0, 5))
