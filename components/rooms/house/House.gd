extends Node2D


# Declare member variables here. Examples:
# var a = 2
var random = RandomNumberGenerator.new()
var key_location = floor(rand_range(1, 5))
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	print(key_location)
	print("here")
	if key_location == 1:
		$BrokenWindowHall/Painting1.has_key = true
	elif key_location == 2:
		$DiningRoom/Bookshelf.has_key = true
	elif key_location == 3:
		$BrokenWindowHall/SmallTable.has_key = true
	elif key_location == 4: 
		$PhoneHallway/Painting2.has_key = true
	
	timer = get_node("Timer")
	timer.set_wait_time(15)
	timer.connect("timeout", self, "text-disappear")

func text_disappear():
	for i in 20:
		$HUD/Message.set_modulate(Color(1, 1, 1, 1/i))
		timer.set_wait_time(1)
		timer.connect("timeout", self, "")
