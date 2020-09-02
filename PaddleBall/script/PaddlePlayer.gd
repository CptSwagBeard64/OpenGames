extends KinematicBody2D

# Constants
const PADDLE_SPEED = 20
const JOYPAD_DEADZONE = 0.15
const JOYPAD_SENSITIVITY = 2

# Object fields
var motion = Vector2()
var startingPos = Vector2(self.position)
var speedMultiplier = 3


# Main physics behavior
func _physics_process(_delta):
	
	var joypad_vec = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_up"):
		motion.y = -PADDLE_SPEED
	elif Input.is_action_pressed("ui_down"):
		motion.y = PADDLE_SPEED
	else:
		motion.y = 0
		
	if Input.get_connected_joypads().size() > 0:
		if OS.get_name() == "Windows":
			#joypad_vec = Vector2(Input.get_joy_axis(0, 0), -Input.get_joy_axis(0, 1))
			joypad_vec = Vector2(0, Input.get_joy_axis(0, 1))
		elif OS.get_name() == "X11":
			joypad_vec = Vector2(Input.get_joy_axis(0, 1), Input.get_joy_axis(0, 2))
		elif OS.get_name() == "OSX":
			joypad_vec = Vector2(Input.get_joy_axis(0, 1), Input.get_joy_axis(0, 2))
		
		if joypad_vec.length() < JOYPAD_DEADZONE:
			joypad_vec = Vector2(0, 0)
		else:
			joypad_vec = joypad_vec.normalized() * PADDLE_SPEED * ((joypad_vec.length() - JOYPAD_DEADZONE) / (1 - JOYPAD_DEADZONE))
			
	if (motion.y == 0):
		global_translate(joypad_vec)
	else:
		global_translate(motion)
