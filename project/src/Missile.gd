extends KinematicBody2D

signal missile_destroyed
signal detonated

var _speed := 300
var _velocity := Vector2()
var _detonated := false

onready var ScreenShake = get_parent().get_parent().get_parent().get_parent().get_child(3).get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
#sets the direction of the asteroids
	if _detonated == false:
		_velocity.x = _speed
		_velocity = move_and_slide(_velocity, Vector2(1, 0))


func _on_Hitbox_body_entered(body):
	if body.is_in_group("Crosshair"):
		_detonate()


func _detonate():
	_detonated = true
	emit_signal("detonated")
	$CPUParticles2D.emitting = true
	$ParticleTimer.start()
	$ExplodeSound.play()
	$Hitbox.set_deferred("disabled", true)
	$AnimatedSprite.hide()
	ScreenShake._start()
	$AreaDamage.scale.x = 1
	$AreaDamage.scale.y = 1


func _on_ParticleTimer_timeout():
	emit_signal("missile_destroyed")
	queue_free()


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Crosshair"):
		_detonate()
