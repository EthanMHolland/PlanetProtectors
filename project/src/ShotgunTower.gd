extends Area2D

signal tower_destroyed

const LASER := preload("Laser.tscn")

var _shots_left : int = 15
var _this_shots := 3


func _ready():
#shoots a laser the moment a tower is placed
	_shoot_laser()
	var level = get_tree().get_root().find_node("Level", true, false)
	level.connect("stop_shooting", self, "_on_stop_shooting")


func _process(_delta):
	_check_shots()


#shoots laser every 3 seconds
func _on_ShootTimer_timeout():
	_shoot_laser()


#spawns a new laser beam, sets its position, and restarts the timer
func _shoot_laser():
	$LaserShootSound.play()
	var _new_laser1 = LASER.instance()
	add_child(_new_laser1)
	_new_laser1.global_position = $Position2D.global_position
	_shots_left -= 1
	_this_shots -= 1
	$ShootTimer.start()
	$MidshotTimer.start()


func _shoot_second_laser():
	$LaserShootSound.play()
	var _new_laser2 = LASER.instance()
	add_child(_new_laser2)
	_new_laser2.global_position = $Position2D2.global_position
	_this_shots -= 1
	$MidshotTimer.start()


func _shoot_third_laser():
	$LaserShootSound.play()
	var _new_laser3 = LASER.instance()
	add_child(_new_laser3)
	_new_laser3.global_position = $Position2D3.global_position
	_this_shots -= 1
	$MidshotTimer.start()


#detects if the tower is hit by an asteroid
func _on_LaserTower_area_entered(area):
	if area.is_in_group("Asteroid"):
		_shots_left -= 5


func _on_MidshotTimer_timeout():
	if _this_shots == 2:
		_shoot_second_laser()
	elif _this_shots == 1:
		_shoot_third_laser()
	elif _this_shots == 0:
		_this_shots = 3


func _check_shots():
	if _shots_left >= 13:
		$AnimatedSprite.play("battery5")
	elif _shots_left >= 10:
		$AnimatedSprite.play("battery4")
	elif _shots_left >= 7:
		$AnimatedSprite.play("battery3")
	elif _shots_left >= 4:
		$AnimatedSprite.play("battery2")
	elif _shots_left >= 1:
		$AnimatedSprite.play("battery1")
	elif _shots_left <= 0:
		$AnimatedSprite.play("battery0")
		emit_signal("tower_destroyed")
		queue_free()


func _on_stop_shooting():
	print("stopped shooting")
	$ShootTimer.stop()
	$StopShooting.start()


func _on_StopShooting_timeout():
	$ShootTimer.start()
