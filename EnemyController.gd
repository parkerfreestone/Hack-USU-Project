extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

var SPEED := 600.0
var GRAVITY := 4500.0


var velocity := Vector2.ZERO


var current_room = 0

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta

	velocity = move_and_slide(velocity, UP_DIRECTION)
