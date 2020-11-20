extends Node2D

signal paused

const BASE_ASTEROID_AMOUNT := 3

var _asteroids_this_wave : int
var _asteroids_left : int
var _asteroids_destroyed : int
var _wave : int = 0
var _total_asteroids_destroyed : int
var _money : int = 10
var _new_asteroid_speed : int = -50
var _earth_health : int = 4

var _rng := RandomNumberGenerator.new()
var _asteroid := preload("Asteroid.tscn")
var _shooting_star := preload("ShootingStar.tscn")



#starts initial wave and money timer
func _ready():
	$BackgroundMusic.play()
	_wave_start()
	$IncreaseMoney.start()
	
	$ShootingStarTimer.start()


#checks if all asteroids have been spawned and updates HUD info
func _process(_delta):
	if(_asteroids_left == 0):
		$SpawnerTimer.stop()
	_check_asteroids_left()
	$AsteroidsLeft.text = "Left: " + str(_asteroids_this_wave - _asteroids_destroyed)
	$Money.text = "$" + str(_money)
	$Wave.text = "Wave: " + str(_wave)
	
	if _wave >= 16:
		var _change_scene = get_tree().change_scene("res://src/WinScreen.tscn")

	if Input.is_action_just_pressed("add_funds"):
		_money += 10

	if Input.is_action_just_pressed("stop_asteroid_spawning"):
		_asteroids_left = 0

	if Input.is_action_just_pressed("increase_wave"):
		_wave_start()
	if Input.is_action_just_pressed("pause"):
		emit_signal("paused")


#Starts the next wave
func _wave_start():
	$NewWaveSound.play()
	_wave += 1
	print("Begin wave: " + str(_wave))
	_new_asteroid_speed -= 10*_wave
# warning-ignore:narrowing_conversion
# Ignored because we want to only spawn integers of asteroids, so we must round and lose precision
	_asteroids_this_wave = round(BASE_ASTEROID_AMOUNT + (pow(_wave, 2) * BASE_ASTEROID_AMOUNT/10))
	_asteroids_left = _asteroids_this_wave
	$SpawnerTimer.start()


#spawns asteroids and randomly chooses their spawn row
func _spawn_asteroid():
	_rng.randomize()
	var _spawn_location = round(_rng.randf_range(0,4))
	
	var _new_asteroid = _asteroid.instance()
	add_child(_new_asteroid)
	if _spawn_location == 0:
		_new_asteroid.global_position = $SpawnPoint1.global_position
	elif _spawn_location == 1:
		_new_asteroid.global_position = $SpawnPoint2.global_position
	elif _spawn_location == 2:
		_new_asteroid.global_position = $SpawnPoint3.global_position
	elif _spawn_location == 3:
		_new_asteroid.global_position = $SpawnPoint4.global_position
	elif _spawn_location == 4:
		_new_asteroid.global_position = $SpawnPoint5.global_position

#connects the destroyed signal from Asteroid.gd to this script
	_new_asteroid.connect("destroyed", self, "_on_AsteroidDestroyed")
	_new_asteroid.speed = _new_asteroid_speed
	
	_asteroids_left -= 1


#checks if all asteroids this wave have been destroyed and if so, starts between wave timer
func _check_asteroids_left():
	if (_asteroids_destroyed >= _asteroids_this_wave and $BetweenWavesTimer.time_left == 0):
		_asteroids_destroyed = 0
		$BetweenWavesTimer.start()


func _on_SpawnerTimer_timeout():
	_spawn_asteroid()
	


func _on_BetweenWavesTimer_timeout():
	$BetweenWavesTimer.stop()
	_wave_start()

	
func _on_AsteroidDestroyed():
	$AsteroidExplodeSound.play()
	_asteroids_destroyed += 1
	_total_asteroids_destroyed += 1
	_money += 2
	


#if an asteroid hits the planet 5 times then it ends the game
func _on_Planet_area_entered(area):
	if area.is_in_group("Asteroid"):
		area.get_parent().queue_free()
		_earth_health -= 1
		if _earth_health == 0:
			var _change_scene = get_tree().change_scene("res://src/EndScreen.tscn")



func _on_IncreaseMoney_timeout():
	_money += 2
	$IncreaseMoney.start()

func _spawn_shooting_star():
	# Choose a random location on Path2D.
	$StarPath/StarSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var _new_star = _shooting_star.instance()
	add_child(_new_star)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $StarPath/StarSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	_new_star.position = $StarPath/StarSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	_new_star.rotation = direction
	# Set the velocity (speed & direction).
	_new_star.linear_velocity = Vector2(rand_range(_new_star.min_speed, _new_star.max_speed), 0)
	_new_star.linear_velocity = _new_star.linear_velocity.rotated(direction)
	_new_star.connect("star_grabbed", self, "_on_star_grabbed")


func _on_ShootingStarTimer_timeout():
	_spawn_shooting_star()
	$ShootingStarTimer.set_wait_time(rand_range(10, 25))
	$ShootingStarTimer.start()


func _on_star_grabbed():
	_money += 10


func _on_Level_paused():
	get_tree().paused = true
	$PauseMenu.show()


func _on_ResumeButton_button_down():
	print("hello")
	$PauseMenu.hide()
	get_tree().paused = false


func _on_MainMenuButton_button_down():
	get_tree().paused = false
	var _change_scene = get_tree().change_scene("res://src/TitleScreen.tscn")
