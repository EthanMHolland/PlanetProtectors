extends KinematicBody2D

const SPEED : int = 200

var _velocity := Vector2()


func _physics_process(_delta):
#Sets the direction of the laser
	var _direction := Vector2(-1, 0)
	_velocity.x = SPEED
	_velocity = move_and_slide(_velocity, Vector2(-1, 0))
