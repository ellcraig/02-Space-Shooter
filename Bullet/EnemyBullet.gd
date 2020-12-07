extends KinematicBody2D

export var velocity = Vector2(0, 10)

export var h = -50

onready var HUD = get_node("/root/Game/HUD")



func _physics_process(_delta):
	position += velocity
	if position.y > get_viewport_rect().size.y + 30:
		queue_free()
 


func _on_Area2D_body_entered(body):
	queue_free()
	HUD.update_health(h)
