extends KinematicBody2D

# Object fields
var speed = 10
var direction = Vector2();
var motion = Vector2()
var player = AudioStream.new()

# Initialization function
func _ready():
	player = get_node("/root/GameManager/AudioStreamPlayer2")
	_ball_reset()

# Physics behavior
func _physics_process(_delta):
	var collision = move_and_collide(direction * speed)
	
	if (collision):
		
		if (collision.collider.name == "North"
		or collision.collider.name == "South"):
			direction.y*=-1
		
		if (collision.collider.name == "PaddlePlayer"
		or collision.collider.name == "PaddleComputer"):
			direction.x*=-1
			_play_sound()
		
		if collision.collider.name == "East":
			var p1 = get_node("/root/GameManager").get("player_one_score")
			get_node("/root/GameManager").set("player_one_score", p1 + 1)
			_ball_reset()
			
		if collision.collider.name == "West":
			var p2 = get_node("/root/GameManager").get("player_two_score")
			get_node("/root/GameManager").set("player_two_score", p2 + 1)
			_ball_reset()

# Reset ball to start position
func _ball_reset():
	position = get_viewport_rect().size / 2
	direction.x = (-1 if randi()%2 == 0 else 1)
	direction.y = (-1 if randi()%2 == 0 else 1)
	
func _play_sound():
	player.play()
