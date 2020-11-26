extends KinematicBody2D

const SPEED : int = 200
var _direction := Vector2(-1, 0)
var _velocity := Vector2()


func _physics_process(_delta):
#Sets the direction of the laser
	_velocity.x = SPEED
	_velocity = move_and_slide(_velocity, _direction)
