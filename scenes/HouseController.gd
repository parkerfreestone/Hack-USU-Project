extends Node2D

# STATIC REFERENCE OF ALL ROOMS
const rooms = [
	preload("res://components/rooms/Room1.tscn"),
	preload("res://components/rooms/Room2.tscn"),
	preload("res://components/rooms/Room3.tscn")
]

const player = preload("res://components/player/Player.tscn")
const enemy = preload("res://components/enemy/Enemy.tscn")
const rooms_per_floor = 8
const floors = 3

func _ready():
	randomize()
	create_map()

func create_room(num, floor_suffix, room_number_suffix):

	var room = null

	room = rooms[num].instance()
	room.name = "Room" + str(floor_suffix) + str(room_number_suffix)
	room.position = Vector2((190 * (room_number_suffix + 1)), (100 * floor_suffix + 1))
	
	add_child(room)

	if room_number_suffix == 2 && floor_suffix == 0:
		var player_entity = player.instance()
		player_entity.position = Vector2(room.position.x, 0)
		add_child(player_entity)



func create_map():
	for i in range(floors):
		for j in range(rooms_per_floor):
			var rand_num = floor(rand_range(0,3))
			create_room(rand_num, i, j)

