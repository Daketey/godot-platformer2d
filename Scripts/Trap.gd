extends Area2D

@export var damage : int = 10
@export var player : CharacterBody2D
@onready var facing_collision_shape : FacingCollisionShape2D = $CollisionShape2D

func _ready():
	pass
	
func _on_body_entered(body):
	print("body entered")
	for child in body.get_children():
		if child is Damageable:
			# Get direction from sword to the body
			var direction_to_damageable = body.global_position - get_parent().global_position
			var direction_sign = sign(direction_to_damageable.y)
			if direction_sign > 0:
				child.hit(damage, Vector2.DOWN)
			elif direction_sign < 0:
				child.hit(damage, Vector2.UP)
			else:
				child.hit(damage, Vector2.ZERO)
					
func _on_player_facing_direction_changed( facing_right : bool):
	if facing_right:
		facing_collision_shape.position = facing_collision_shape.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position
