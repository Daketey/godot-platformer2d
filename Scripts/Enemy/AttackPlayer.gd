extends State

@export var attack_area : Area2D
@export var fly_state : State

func _ready():
	attack_area.connect("attack_player", _attack_player)
	
	
func _attack_player(has_entered):
	if has_entered == false:
		next_state = fly_state
		playback.travel("fly")

