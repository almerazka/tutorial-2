extends CharacterBody2D
var Laser = preload("res://scenes/Enemylaser.tscn")
var player = null
var canlaser = true
@export var speed = 2
@onready var spawnpos = $Spawnpos

func _ready():
	$Detection.body_entered.connect(_on_Detection_body_entered)
	$Detection.body_exited.connect(_on_Detection_body_exited)

func _on_Detection_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		laser()

func _on_Detection_body_exited(body):
	if body.is_in_group("Player"):
		player = null

func _physics_process(delta):
	var movement = Vector2(-2, 0)
	if player:
		movement = position.direction_to(player.position) * speed
	move_and_collide(movement)

func _on_laserspeed_timeout() -> void:
	canlaser = true
	if player != null:
		laser()

func laser():
	if canlaser:
		var laser = Laser.instantiate()
		laser.global_position = spawnpos.global_position
		get_tree().current_scene.call_deferred("add_child", laser)
		$Laserspeed.start()
		canlaser = false
