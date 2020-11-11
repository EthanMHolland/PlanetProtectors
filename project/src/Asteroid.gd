extends KinematicBody2D

signal destroyed

var speed := -50

var _velocity := Vector2()


func _physics_process(_delta):
	var _direction := Vector2(-1, 0)
	_velocity.x = speed
	
	_velocity = move_and_slide(_velocity, Vector2(-1, 0))


func set_speed():
	print("meow")

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Laser"):
		emit_signal("destroyed")
		queue_free()
		body.queue_free()


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Tower"):
		emit_signal("destroyed")
		queue_free()
