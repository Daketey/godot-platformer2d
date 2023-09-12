extends State
class_name EnemyRunState


@export var raycast : RayCast2D
@export var tracking_area: Area2D
@export var tracking_state : State
@export var check_pit: RayCast2D

@onready var timer : Timer = $Buffer


var tracking = false

var direction = Vector2.ZERO

func _ready():
	tracking_area.connect("enter_player", track_player)
	direction = Vector2.LEFT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	
	if tracking:
		next_state = tracking_state
		
	if timer.is_stopped():
		if raycast.is_colliding() or (not check_pit.is_colliding() and character.is_on_floor()):
				direction.x *= -1
		timer.start()
		
	if direction != Vector2.ZERO:
			character.velocity = direction*character.SPEED
	
func track_player(is_in_area):
	tracking = is_in_area
