extends Area2D

var speed = 400

func _physics_process(delta):
	position -= Vector2(speed, 0) * delta
