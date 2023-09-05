extends State
class_name FlyState

@export var attack_area : Area2D
@export var attack_state : State

func _ready():
	attack_area.connect("attack_player", _attack_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _attack_player(has_entered):
	if has_entered:
		next_state = attack_state
		playback.travel("attack")
