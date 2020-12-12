extends KinematicBody2D

class_name Asteroid

signal destroyed
signal hit

var _speed : int = -50
var _velocity := Vector2()
var _health := 3
var _stunned = false


func _process(_delta):
	if _health > 0:
		_check_health()
	if Input.is_action_just_pressed("increase_wave"):
		queue_free()

func _physics_process(_delta):
#sets the direction of the asteroids
	var _direction := Vector2(-1, 0)
	_velocity.x = _speed
	_velocity = move_and_slide(_velocity, Vector2(-1, 0))
	$Sprite.rotation -= 0.01

#detects when a laser hit the asteroids and deletes the asteroid/laser and emits "destroyed"
func _on_Hitbox_body_entered(body):
	if body.is_in_group("Laser"):
		$CPUParticles2D.emitting = true
		$ParticleTimer.start()
		emit_signal("hit")
		_health -= 1
		_check_health()
		body.queue_free()


#detects when the asteroids hits a tower and deletes the asteroid and emits "destroyed"
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Tower"):
		$CPUParticles2D.emitting = true
		$ParticleTimer.start()
		emit_signal("hit")
		_health -= 1
		_check_health()

func _check_health():
	if _health == 3:
		$Sprite.play("large")
	elif _health == 2:
		$Sprite.play("medium")
	elif _health == 1:
		$Sprite.play("small")
	elif _health <= 0:
		emit_signal("destroyed")
		$Hitbox.set_deferred("disabled", true)
		$Sprite.hide()


func _on_ParticleTimer_timeout():
	if _health <= 0:
		queue_free()

func hit_by_misile():
	$CPUParticles2D.emitting = true
	$ParticleTimer.start()
	emit_signal("hit")
	_health -= 1
	_check_health()
