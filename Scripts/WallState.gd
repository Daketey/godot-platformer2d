extends State

class_name WallState

@export var jump_velocity = 200.0
@export var air_state : State
@export var landing_state: State
@export var raycast : RayCast2D
@export var player : CharacterBody2D

@onready var timer : Timer = $Timer
@onready var spam_timer : Timer = $WallCoyote
var facing : int = 1
var last_jump = -1


func _ready():
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)

func on_enter():
	timer.start()


func state_process(delta):
	if not check_valid_walls():
		next_state = air_state
		playback.travel("jump")
		
	if check_valid_walls() and not timer.is_stopped():
		wall_climb(delta)
		
	if character.is_on_floor():
		playback.travel("RESET")
		next_state = landing_state

func state_input(event : InputEvent):
	if Input.is_action_just_pressed("jump"):
			wall_jump()
			
func check_valid_walls():
	if raycast.is_colliding():
		var res = acos(Vector2.UP.dot(raycast.get_collision_normal()))
		if res > PI*0.35 and res < PI*0.55:
			print(player.global_position - raycast.position)
			return true
		else:
			return false

func wall_jump():
		print(facing)
		character.velocity.x = -1*facing*800
		character.velocity.y = -300

	
func wall_climb(delta):
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and not Input.is_action_pressed("up"):
		character.velocity.y = 70 * delta
		character.velocity.y = min(character.velocity.y, 50)
	elif Input.is_action_pressed("up"):
		character.velocity.y = -150
	
func _on_player_facing_direction_changed(facing_direction):
	if facing_direction != 0:
		facing = facing_direction


