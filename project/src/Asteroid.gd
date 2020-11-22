extends KinematicBody2D

signal destroyed

var _speed : int = -50
var _velocity := Vector2()


func _process(_delta):
	if Input.is_action_just_pressed("increase_wave"):
		queue_free()

func _physics_process(_delta):
#sets the direction of the asteroids
	var _direction := Vector2(-1, 0)
	_velocity.x = _speed
	_velocity = move_and_slide(_velocity, Vector2(-1, 0))
	rotation -= 0.01

#detects when a laser hit the asteroids and deletes the asteroid/laser and emits "destroyed"
func _on_Hitbox_body_entered(body):
	if body.is_in_group("Laser"):
		emit_signal("destroyed")
		queue_free()
		body.queue_free()


#detects when the asteroids hits a tower and deletes the asteroid and emits "destroyed"
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Tower"):
		emit_signal("destroyed")
		queue_free()
