extends State
class_name FlyState




@export var raycasts : Array[RayCast2D]
@export var tracking_area: Area2D
@export var tracking_state : State

@onready var timer : Timer = $Timer

var tracking = false

var direction = Vector2.ZERO

var nums = [-1, 1]

func _ready():
	tracking_area.connect("enter_player", track_player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	
	if tracking:
		next_state = tracking_state
	
	if timer.is_stopped():
		direction = Vector2(nums[randi() % nums.size()], 0)
		is_about_to_collide()
		timer.start()
		
	if direction != Vector2.ZERO:
			character.velocity = direction*character.SPEED
	

		
func is_about_to_collide():
	for raycast in raycasts:
		if raycast.is_colliding():
			var dir = -1 * sign(raycast.target_position)
			direction = dir
			
func track_player(is_in_area):
	tracking = is_in_area
