extends Area2D

@export var player : CharacterBody2D
@export var facing_collision_shape : FacingCollisionShape2D

signal flip_signal(direction : int)

func _ready():
	monitoring = true
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)


func _on_player_facing_direction_changed( facing_right : bool):
	if facing_right:
		facing_collision_shape.position = facing_collision_shape.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position


func _on_body_exited(body):
	var direction_to_damageable = body.global_position - get_parent().global_position
	var direction_sign = sign(direction_to_damageable.x)
	emit_signal("flip_signal", direction_sign)
	
