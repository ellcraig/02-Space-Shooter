extends KinematicBody2D

export var health = 100
export var s = 10

export var move_probability = 0.4
export var shoot_probability = 0.2
export var speed = 2.0
onready var w = int(get_viewport_rect().size.x)
onready var h = int(get_viewport_rect().size.y)


onready var HUD = get_node("/root/Game/HUD")
onready var Bullet = load("res://Bullet/Bullet.tscn")

func _ready():
	randomize()

func move():
	var new_position = Vector2(randi() % w, randi() % h)
	$Tween.interpolate_property(self, "position", position, new_position, speed, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Tween.start()


func shoot():
	var bullet = Bullet.instance()
	bullet.position = position
	get_node("/root/Game/Bullets").add_child(bullet)

func _on_Move_timeout():
	if randf() < move_probability: 
		move()


func _on_Shoot_timeout():
	if randf() < shoot_probability:
		shoot()

func die():
	HUD.update_score(s)
	queue_free()
