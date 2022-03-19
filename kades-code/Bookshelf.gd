extends Node2D

var has_key = false;

var velocity = Vector2()
var key_sprite = load("res://hadleys-art/key.png")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer

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
		print("can hide")
		body.can_hide = true
		if has_key:
			$Sprite.set_texture(key_sprite)
			velocity.y = 4
			timer.start()
			body.key = true
	$Light2D.energy = 1
		


func _on_Area2D_body_exited(body:Node):
	if body.name == "Player":
		$Light2D.energy = 0
		body.can_hide = false

func key_disappear():		
	hide()
			
