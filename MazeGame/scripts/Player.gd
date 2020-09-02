extends KinematicBody

const SPEED = 5
const FRAMES_PER_SECOND = 60
const H_LOOK_SENSE = 0.05

onready var camera = $Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(_delta):
	var dir = _get_move_direction()
	move_and_slide(dir, Vector3(0, 1, 0))

func _get_move_direction():
	var dir = Vector3()
	var rot_x = 0
	
	if Input.is_action_pressed("ui_up"):
		dir += transform.basis.z
	elif Input.is_action_pressed("ui_down"):
		dir -= transform.basis.z
#	if Input.is_action_pressed("ui_left"):
#		dir += transform.basis.x
#	elif Input.is_action_pressed("ui_right"):
#		dir -= transform.basis.x
	
	if Input.get_action_strength("ui_left"):
		rot_x = Input.get_action_strength("ui_left") * H_LOOK_SENSE
	elif Input.get_action_strength("ui_right"):
		rot_x = Input.get_action_strength("ui_right") * -1 * H_LOOK_SENSE
	else:
		rot_x = 0
	
	#transform.basis = Basis() # reset rotation
	rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in Y
	
	return dir * SPEED
