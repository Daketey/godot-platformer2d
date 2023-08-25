extends State

class_name Dash

var direction = Vector2.RIGHT

func state_input(event : InputEvent):
	if event.is_action_pressed("shift") and event.is_action_pressed("right"):
		dash()
	
func dash():
	character.velocity = direction*300
