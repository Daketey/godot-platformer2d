extends RayCast2D

var raycast = self
	
signal is_on_wall(is_on_wall : bool)


func _check_valid_walls():
	if raycast.is_colliding():
		var res = acos(Vector2.UP.dot(raycast.get_collision_normal()))
		if res > PI*0.35 and res < PI*0.55:
			print("true")
			emit_signal('is_on_wall', true)
			return

func flip_to(direction):
	raycast.target_position *= direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_check_valid_walls()

