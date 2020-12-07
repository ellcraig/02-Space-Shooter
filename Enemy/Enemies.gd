extends Node2D

onready var Enemy = load("res://Enemy/Enemy.tscn")
export var spawn_probability = .25
export var max_count = 6
onready var w = int(get_viewport_rect().size.x)


func _ready():
	randomize()





func _on_Timer_timeout():
	if randf() < spawn_probability and get_child_count() < max_count +1:
		var enemy = Enemy.instance()
		enemy.position = Vector2(randi() % w, -200)
		get_node("/root/Game/Enemies").add_child(enemy)
