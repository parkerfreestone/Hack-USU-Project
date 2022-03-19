extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = get_node("Button")
	button.text = "Play Again"
	button.connect("pressed", self, "_button_pressed")
	add_child(button)

func _button_pressed():
	get_tree().change_scene("res://kades-code/House.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
