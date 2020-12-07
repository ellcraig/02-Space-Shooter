extends KinematicBody2D

export var velocity = Vector2(0, -10)

export var damage = 50

onready var HUD = get_node("/root/Game/HUD")
var s = 10


func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	position += velocity
	if position.y < get_viewport_rect().size.y - 550:
		queue_free()

func die():
	HUD.update_score(s)
	queue_free()




func _on_Area2D_body_entered(body):
	body.die()
