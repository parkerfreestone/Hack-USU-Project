extends KinematicBody2D

const UP_DIRECTION = Vector2.UP

var SPEED = 15
var GRAVITY = 4000
var ACCELERATION = 1

var velocity = Vector2()
var moving_left = false
var key = false

export var current_room = 0

var stamina = 100
var hidden = false
var can_hide = false
var alive = true

func get_input():
	if stamina < 100:
		stamina += .5
	velocity = Vector2()

	if moving_left:
		$Sprite.flip_h = true
	elif !moving_left:
		$Sprite.flip_h = false

	if Input.is_action_pressed("move_left"):
		velocity.x += -ACCELERATION
		moving_left = true
		$AnimationPlayer.play("Walk")
	if Input.is_action_pressed("move_right"):
		velocity.x += ACCELERATION
		moving_left = false
		$AnimationPlayer.play("Walk")
	if Input.is_action_pressed("sprint") && stamina > 17:
		SPEED = 60
		stamina -= 1
		if stamina < 20:
			stamina = 0;
			SPEED = 15
	
	if Input.is_action_just_released("sprint"):
		SPEED = 15

	if Input.is_action_pressed("hide") && !	velocity.x:
		$AnimationPlayer.play("Crouch")
		if can_hide:
			hidden = true
			get_parent().get_child(6).set_collision_layer_bit(0, false)
			get_parent().get_child(6).set_collision_layer_bit(1, false)
			$Sprite.set_modulate(Color(1, 1, 1, 0.5))
	
	if Input.is_action_just_released("hide"):
		hidden = false	
		get_parent().get_child(6).set_collision_layer_bit(0, true)
		$Sprite.set_modulate(Color(1, 1, 1, 1))

	if velocity.x == 0:
		if !hidden:
			$AnimationPlayer.play("Idle")
		elif hidden:
			$AnimationPlayer.play("Crouch")

	velocity = velocity.normalized() * SPEED
	


func _physics_process(delta):

	get_input()
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity, UP_DIRECTION)

	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.name == "MainEnemy":
			get_tree().change_scene("res://kades-code/Defeat.tscn")

