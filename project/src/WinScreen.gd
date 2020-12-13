extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	_randomize_firework_time()

func _on_PlayAgain_button_down():
	var _change_scene = get_tree().change_scene("res://src/Level.tscn")


func _on_MainMenu_button_down():
	var _change_scene = get_tree().change_scene("res://src/TitleScreen.tscn")


func _randomize_firework_time():
	rng.randomize()
	var rand1 = rng.randf_range(0.0, 4)
	rng.randomize()
	var rand2 = rng.randf_range(0.0, 4)
	rng.randomize()
	var rand3 = rng.randf_range(0.0, 4)
	rng.randomize()
	var rand4 = rng.randf_range(0.0, 4)
	rng.randomize()
	$ParticleTimer.wait_time = rand1
	$ParticleTimer2.wait_time = rand2
	$ParticleTimer3.wait_time = rand3
	$ParticleTimer4.wait_time = rand4
	_randomize_firework_size()
	
	$ParticleReplayTimer.start()
	$ParticleTimer.start()
	$ParticleTimer2.start()
	$ParticleTimer3.start()
	$ParticleTimer4.start()


func _randomize_firework_size():
	rng.randomize()
	var randsize1 = rng.randf_range(1, 2.5)
	var randsize2 = rng.randf_range(1, 2.5)
	var randsize3 = rng.randf_range(1, 2.5)
	var randsize4 = rng.randf_range(1, 2.5)
	$FireworksParticles.scale = Vector2(randsize1, randsize1)
	$FireworksParticles2.scale = Vector2(randsize2, randsize2)
	$FireworksParticles3.scale = Vector2(randsize3, randsize3)
	$FireworksParticles4.scale = Vector2(randsize4, randsize4)


func _on_ParticleTimer_timeout():
	$FireworksParticles.emitting = true


func _on_ParticleTimer2_timeout():
	$FireworksParticles2.emitting = true


func _on_ParticleTimer3_timeout():
	$FireworksParticles3.emitting = true


func _on_ParticleTimer4_timeout():
	$FireworksParticles4.emitting = true


func _on_ParticleReplayTimer_timeout():
	_randomize_firework_time()
