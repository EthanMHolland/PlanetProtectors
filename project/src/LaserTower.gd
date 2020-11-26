extends Area2D

signal tower_destroyed

const LASER := preload("Laser.tscn")

var _bar_red := preload("res://assets/healthbar_red.png")
var _bar_green := preload("res://assets/healthbar_green.png")
var _bar_yellow := preload("res://assets/healthbar_yellow.png")


var _health : int = 3
var _shots_left : int = 15

func _ready():
#shoots a laser the moment a tower is placed
	_shoot_laser()


func _process(_delta):
	_check_health()
	_check_shots()




#shoots laser every 3 seconds
func _on_ShootTimer_timeout():
	_shoot_laser()


#spawns a new laser beam, sets its position, and restarts the timer
func _shoot_laser():
	$LaserShootSound.play()
	var _new_laser = LASER.instance()
	add_child(_new_laser)
	_new_laser.global_position = $Position2D.global_position
	_shots_left -= 1
	$ShootTimer.start()


#detects if the tower is hit by an asteroid
func _on_LaserTower_area_entered(area):
	if area.is_in_group("Asteroid"):
		_health -= 1
		


func _check_health():
	if _health == 3:
		$HealthBar.value = 3
	elif _health == 2:
		$HealthBar.value = 2
		$HealthBar.texture_progress = _bar_yellow
	elif _health == 1:
		$HealthBar.value = 1
		$HealthBar.texture_progress = _bar_red
	elif _health == 0:
		#$HealthBar.value == 0
		emit_signal("tower_destroyed")
		queue_free()

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
	
