extends State

class_name WallState

@export var jump_velocity = 200.0
@export var air_state : State
@export var landing_state: State
@export var ray_casts : Array[RayCast2D] = []

@onready var timer : Timer = $Timer
@onready var spam_timer : Timer = $SpamTimer
var facing : int = 1
var last_jump = -1


func on_enter():
	timer.start()
#	already_jumped = false


func state_process(delta):
	if not check_valid_walls():
		next_state = air_state
		
	if check_valid_walls() and not timer.is_stopped():
		wall_slide(delta)
		
	if character.is_on_floor():
		playback.travel("RESET")
		last_jump = -1*facing
		next_state = landing_state

func state_input(event : InputEvent):
	if  not timer.is_stopped() and spam_timer.is_stopped():
		spam_timer.start()
		wall_jump()
		
	if timer.is_stopped():
		character.velocity.x = facing*300
		character.velocity.y = 100
			
func check_valid_walls():
	for raycast in ray_casts:
		if raycast.is_colliding():
			var res = acos(Vector2.UP.dot(raycast.get_collision_normal()))
			if res > PI*0.35 and res < PI*0.55:
				facing = -1 * sign(raycast.get_target_position().x)
				return true
			else:
				return false

func wall_jump():
		character.velocity = Vector2(facing * 200,-500)

	
func wall_slide(delta):
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		character.velocity.y = 70 * delta
		character.velocity.y = min(character.velocity.y, 100)
	


