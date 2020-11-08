extends Area2D

signal tower_destroyed

const LASER = preload("Laser.tscn")

var _health := 3
var _shots_left := 15

func _ready():
	_shoot_bullet()


func _process(_delta):
	if _health <= 0:
		emit_signal("tower_destroyed")
		queue_free()
		
	if _shots_left <= 0:
		emit_signal("tower_destroyed")
		queue_free()


func _on_ShootTimer_timeout():
	_shoot_bullet()

func _shoot_bullet():
	var _new_laser = LASER.instance()
	add_child(_new_laser)
	_new_laser.global_position = $Position2D.global_position
	_shots_left -= 1
	
	$ShootTimer.start()


func _on_LaserTower_area_entered(area):
	if area.is_in_group("Asteroid"):
		_health -= 1
