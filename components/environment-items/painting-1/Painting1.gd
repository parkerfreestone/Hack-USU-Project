extends Node2D

var has_key = false;

var velocity = Vector2()
var key_sprite = load("res://hadleys-art/key.png")

var timer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("Timer")
	timer.set_wait_time(1)
	timer.connect("timeout", self, "key_disappear")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body:Node):
	if body.name == "Player":
		if has_key:
			$Light2D.energy = 1
			$Sprite.set_texture(key_sprite)
			velocity.y = 4
			timer.start()
			body.key = true
			
			

func _on_Area2D_body_exited(body:Node):
	if body.name == "Player":
		$Light2D.energy = 0

		
func key_disappear():
	hide()
