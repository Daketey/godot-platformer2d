extends State

var tracking = false

@export var nav_agent : NavigationAgent2D
@export var fly_state : State
@export var attack_area : Area2D
@export var attack_state : State

var direction = Vector2.ZERO

@onready var tracking_time : Timer = $TrackingTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	attack_area.connect("attack_player", _attack_player)

func on_enter():
	tracking_time.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	
	if tracking_time.is_stopped():
		next_state = fly_state
	
	direction = character.to_local(nav_agent.get_next_path_position()).normalized()
		
	if direction != Vector2.ZERO:
			character.velocity = direction*character.SPEED


func _attack_player(has_entered):
	if has_entered:
		next_state = attack_state
		playback.travel("attack")
	
func make_path():
	nav_agent.target_position = character.player.global_position
		
func _on_timer_timeout():
	make_path()


func _on_tracking_area_body_exited(body):
	tracking_time.start()
