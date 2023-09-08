extends Area2D

@export var damage : int = 10
@export var player : CharacterBody2D
@export var facing_collision_shape : CollisionShape2D

func _ready():
#	monitoring = false
	pass

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			# Get direction from sword to the body
			var direction_to_damageable = body.global_position - get_parent().global_position
			var direction_sign = sign(direction_to_damageable)
			child.hit(damage, direction_sign)
			
