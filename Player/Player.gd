extends KinematicBody2D

export var health = 100
export var score = 0
export var margin = 5
export var y_range = 300
export var acceleration = 0.1

var velocity = Vector2(0,0)

onready var HUD = get_node("/root/Game/HUD")

onready var VP = get_viewport_rect().size

onready var Bullet = load("res://Bullet/PlayerBullet.tscn")

onready var CooldownTimer = $Cooldown

signal health_changed
signal score_changed

func _ready():
	emit_signal("health_changed")
	emit_signal("score_changed")

func change_health(h):
	health += h
	emit_signal("health_changed")
	if health <= 0:
		die()

func change_score(s):
	score += s
	emit_signal("score_changed")

func die():
	queue_free()
	get_tree().change_scene("res://Menu/Menu.tscn")


func _physics_process(_delta):
	if Input.is_action_pressed("Shoot") and _on_Cooldown_timeout():
			var bullet = Bullet.instance()
			bullet.position = position
			get_node("/root/Game/Bullets").add_child(bullet)
	if Input.is_action_pressed("Left"):
		velocity.x -= acceleration
	if Input.is_action_pressed("Right"): 
		velocity.x += acceleration
	if Input.is_action_pressed("Up"):
		velocity.y -= acceleration
	if Input.is_action_pressed("Down"):
		velocity.y += acceleration

	if position.x < margin:
		velocity.x = 0
		position.x = margin
	if position.x > VP.x - margin:
		velocity.x = 0
		position.x = VP.x - margin
	if position.y < VP.y - y_range:
		velocity.y = 0
		position.y = VP.y - y_range
	if position.y > VP.y - margin:
		velocity.y = 0
		position.y = VP.y - margin
	var collision = move_and_collide(velocity)

func _on_Area2d_body_entered(body):
	HUD.update_health(-body.damage)
	body.die()





func _on_Cooldown_timeout():
	if Input.is_action_pressed("Shoot"):
		CooldownTimer.start()
		var bullet = Bullet.instance()
		bullet.position = position
		get_node("/root/Game/Bullets").add_child(bullet)
