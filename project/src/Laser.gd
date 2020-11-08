extends KinematicBody2D

const SPEED := 200

var _velocity := Vector2()


func _physics_process(_delta):
	var _direction := Vector2(-1, 0)
	_velocity.x = SPEED
	
	_velocity = move_and_slide(_velocity, Vector2(-1, 0))
