extends KinematicBody2D

const UP_DIRECTION = Vector2.UP

var SPEED = 600.0
var GRAVITY = 4500.0
onready var MAIN_PLAYER = get_parent().get_parent().get_node("Player")


var velocity = Vector2.ZERO
var current_room = 0

func _physics_process(delta):
	velocity.y += WorldController.GRAVITY * delta
	velocity = move_and_slide(velocity, UP_DIRECTION)

