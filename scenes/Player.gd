extends CharacterBody2D
var Laser = preload("res://scenes/Playerlaser.tscn")
var speed = 400
var canlaser = true
@onready var spawnpos = $Spawnpos
@onready var spawnpos2 = $Spawnpos2
@onready var burst = $Burst
@onready var burst2 = $Burst2

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	global_position.x = clamp(global_position.x, 40, 1110)
	global_position.y = clamp(global_position.y, 50, 600)
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("WinPlatform"):
			win()

func _process(delta):
	if Input.is_action_pressed("laser") and canlaser:
		laser()

func laser():
	canlaser = false
	
	var laser = Laser.instantiate()
	laser.global_position = spawnpos.global_position
	get_tree().current_scene.add_child(laser)
	
	burst.play("Burst")
	
	var laser2 = Laser.instantiate()
	laser2.global_position = spawnpos2.global_position
	get_tree().current_scene.add_child(laser2)
	
	burst2.play("Burst2")
	
	await get_tree().create_timer(0.3).timeout
	canlaser = true
func win():
	print("MENANG!")
	get_tree().change_scene_to_file("res://scenes/WinScreen.tscn")
