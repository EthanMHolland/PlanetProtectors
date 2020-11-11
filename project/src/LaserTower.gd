extends Area2D

signal tower_destroyed

const LASER = preload("Laser.tscn")

var _health := 3
var _shots_left := 15

func _ready():
#shoots a laser the moment a tower is placed
	_shoot_laser()


func _process(_delta):
#deletes tower if health is 0 or below
	if _health <= 0:
		emit_signal("tower_destroyed")
		queue_free()

#deletes tower if amount of shots left is 0 or below
	if _shots_left <= 0:
		emit_signal("tower_destroyed")
		queue_free()


#shoots laser every 3 seconds
func _on_ShootTimer_timeout():
	_shoot_laser()


#spawns a new laser beam, sets its position, and restarts the timer
func _shoot_laser():
	var _new_laser = LASER.instance()
	add_child(_new_laser)
	_new_laser.global_position = $Position2D.global_position
	_shots_left -= 1
	$ShootTimer.start()


#detects if the tower is hit by an asteroid
func _on_LaserTower_area_entered(area):
	if area.is_in_group("Asteroid"):
		_health -= 1
