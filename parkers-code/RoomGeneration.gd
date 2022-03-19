extends Node2D

const rooms = {
	"Broken Window Hall": preload("res://kades-code/Room.tscn"),
	# "Phone Hall": preload("res://kades-code/Room.tscn"),
	# "Safe Room": preload("res://kades-code/Room.tscn"),
	# "Parent Bedroom": preload("res://kades-code/Room.tscn"),
	# "Stair Room": preload("res://kades-code/Room.tscn"),
	# "Bedroom": preload("res://kades-code/Room.tscn"),
	# "Living Room": preload("res://kades-code/Room.tscn"),
	# "Dining Room": preload("res://kades-code/Room.tscn"),
	# "Hallway": preload("res://kades-code/Room.tscn"),
	# "Entertainment Room": preload("res://kades-code/Room.tscn")
}

const rooms_per_floor = 8
const floors = 3

# KEEP TRACK OF NUMBER OF ROOMS
var bwh = 0
var ph = 0
var sr = 0
var pb = 0
var sfr = 0
var b = 0
var lr = 0
var dr = 0
var h = 0
var er = 0


func _ready():
	make_rooms()


func make_rooms():
	# for i in range(floors):
	# 	for j in range(rooms_per_floor):
	$Rooms.add_child(rooms["Broken Window Hall"].instance())
	# generateRandomRoom()


func generateRandomRoom():
	var r = rooms["Broken Window Hall"].instance()
	r.make_room(Vector2(50,50))
	$Rooms.add_child(r)
		
