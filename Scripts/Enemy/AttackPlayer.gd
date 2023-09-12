extends State

@export var attack_area : Area2D
@export var return_state : State

func _ready():
	attack_area.connect("attack_player", _attack_player)
	
func on_enter():
	character.velocity = Vector2.ZERO
	
func _attack_player(has_entered):
	if has_entered == false:
		next_state = return_state
		playback.travel("run")

