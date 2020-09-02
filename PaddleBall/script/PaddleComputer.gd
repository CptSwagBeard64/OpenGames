extends KinematicBody2D

# Constants
const PADDLE_SPEED = 5

# Object fields
var motion = Vector2()

# Main physics behavior
func _physics_process(_delta):
	var ball_y = get_node("/root/GameManager/Ball").get("position").y
	
	if (ball_y > position.y):
		motion.y = PADDLE_SPEED
	elif (ball_y < position.y):
		motion.y = -PADDLE_SPEED
	else:
		motion.y = 0
	
	global_translate(motion)
