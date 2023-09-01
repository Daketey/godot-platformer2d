extends State

var direction : Vector2 = Vector2.ZERO
@export var acceleration : int = 70
@export var friction : float = 0.2
@export var max_horizontal_velocity : int = 180
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent))
