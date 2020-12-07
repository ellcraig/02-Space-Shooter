extends KinematicBody2D

export var velocity = Vector2(0, 10)



func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	position += velocity
	if position.y > get_viewport_rect().size.y + 30:
		queue_free()
