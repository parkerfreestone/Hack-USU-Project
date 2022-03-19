extends KinematicBody2D

const UP_DIRECTION = Vector2.UP

var GRAVITY = 4500.0
onready var MAIN_PLAYER = get_parent().get_node("Player")
var ACCELERATION = 1

var velocity = Vector2()
var enemy_current_room = 0
var players_room = 0

func _physics_process(delta):

	

	

func _on_Player_change_room(room):
	players_room = room
