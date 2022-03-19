extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed := 600.0 
export var gravity := 4500.0

var velocity := Vector2.ZERO


# CONTROL FLOW
var current_room = 0
var players_room = 0


func _process(delta: float):
	playrs_room = get_node("PlayerCharacter").current_room

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta


	if (current_room - players_room) < 3:
		velocity.x.lerp(

	velocity = move_and_slide(velocity, UP_DIRECTION)
