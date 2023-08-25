extends State

class_name HitState

@export var damageable : Damageable
@export var dead_state : State
@export var dead_animation : String = "dead"
@export var knockback_velocity : float = 100.0
@export var return_state : State
@onready var timer : Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	damageable.connect("on_hit", on_damageable_hit)

func on_enter():
	timer.start()
	
func on_exit():
	character.velocity = Vector2.ZERO

func on_damageable_hit(node: Node, damage_amount : int, knockback_direction : Vector2):
	if damageable.health > 0:
		character.velocity = knockback_velocity * knockback_direction
		emit_signal("interrupt_signal", self)
	else:
		emit_signal("interrupt_signal", dead_state)
		playback.travel(dead_animation)


func _on_timer_timeout():
	next_state = return_state
	playback.travel("idle")
