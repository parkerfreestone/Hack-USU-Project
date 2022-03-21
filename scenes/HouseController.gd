extends Node2D

# STATIC REFERENCE OF ALL ROOMS
const rooms = [
	preload("res://components/rooms/Room1.tscn"),
	preload("res://components/rooms/Room2.tscn"),
	preload("res://components/rooms/Room3.tscn")
]

const wall_decorations = [
	preload("res://components/environment-items/painting-1/Painting1.tscn"),
	preload("res://components/environment-items/painting-2/Painting2.tscn"),
	preload("res://components/environment-items/painting-3/Painting3.tscn"),
]

const floor_decoration = [
	preload("res://components/environment-items/small-table/SmallTable.tscn"),
	preload("res://components/environment-items/tv/TV.tscn"),
	preload("res://components/environment-items/table-with-phone/PhoneTable.tscn"),
]

const interactable_objects = [
	preload("res://components/environment-items/bookshelf/Bookshelf.tscn"),
	preload("res://components/environment-items/cabinet/Cabinet.tscn"),
	preload("res://components/environment-items/table/Table.tscn"),
]

const player = preload("res://components/player/Player.tscn")
const enemy = preload("res://components/enemy/Enemy.tscn")
const rooms_per_floor = 8
const floors = 3

func _ready():
	randomize()
	create_map()

func create_room(room_num, dec_num, dec_chance, int_chance, floor_number, room_number):

	# OUR DECORATION PLACEHOLDERS
	var room = null
	var decoration = null
	var interactable = null

	# DETERMINE WHAT EACH ROOM HAS
	var has_wall_decoration = bool(dec_chance)
	var has_interactable_object = bool(int_chance)

	# GENERATE OUR BASE ROOMS
	room = rooms[room_num].instance()
	room.name = "Room" + str(floor_number) + str(room_number)
	room.position = Vector2((190 * (room_number + 1)), (100 * floor_number + 1))
	add_child(room)

	# CONDITIONALLY GIVE ROOM DECORATIONS
	if has_wall_decoration:
		decoration = wall_decorations[dec_num].instance()
		decoration.name = "WallDecoration" + str(floor_number) + str(room_number)
		decoration.position = room.position + Vector2(-50, 0)
	elif !has_wall_decoration:
		decoration = floor_decoration[dec_num].instance()
		decoration.name = "WallDecoration" + str(floor_number) + str(room_number)
		decoration.position = room.position + Vector2(-50, 32)
	add_child(decoration)

	if has_interactable_object:
		interactable = interactable_objects[dec_num].instance()
		interactable.name = "Interactable" + str(floor_number) + str(room_number)
		interactable.position = room.position + Vector2(50, 18)
		add_child(interactable)

	# SPAWN PLAYER AND ENEMY
	if room_number == 2 && floor_number == 2:
		var player_entity = player.instance()
		player_entity.position = room.position
		add_child(player_entity)

	if room_number == 4 && floor_number == 2:
		var enemy_entitiy = enemy.instance()
		enemy_entitiy.position = room.position
		add_child(enemy_entitiy)


func create_map():
	for i in range(floors):
		for j in range(rooms_per_floor):
			var room_rand_num = floor(rand_range(0,3))
			var decoration_rand_num = floor(rand_range(0,3))
			var wall_decoration_chance = floor(rand_range(0,2))
			var interaction_chance = floor(rand_range(0,2))

			create_room(room_rand_num, decoration_rand_num, wall_decoration_chance, interaction_chance, i, j)

