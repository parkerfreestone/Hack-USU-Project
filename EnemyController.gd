extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed := 600.0 
export var gravity := 4500.0

var velocity := Vector2.ZERO


var current_room = 0
onready var player_node = get_node("Player")


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	if (current_room - player_node.players_room) < 3:
		print(player_node.get_position_in_parent())

	velocity = move_and_slide(velocity, UP_DIRECTION)
