extends Node2D

signal title_button_pressed

func _ready():
	_set_default_text()


func _on_LaserTower_mouse_entered():
	$InfoText.text = "Laser Tower\n\n- Cost $10 to place\n- Battery lasts for 15 shots before dying\n- Can take 3 hits from asteroids before being destroyed"


func _set_default_text():
	$InfoText.text = "Welcome to Planet Protectors!\nThere are asteroids heading toward Earth and we need your help to stop them!\n\n- Drag and drop towers in the grid to fight back!\n- Catch Shooting Stars for extra money!\n- Beat Wave 15 to win!\nGood Luck!"


func _on_BackButton_button_down():
	emit_signal("title_button_pressed")


func _on_Asteroid_mouse_entered():
	$InfoText.text = "Asteroid\n\n- Can take 3 hits from a Laser before being destroyed\n- Speed increases with wave count"
	

func _on_LaserTower_mouse_exited():
	_set_default_text()


func _on_Asteroid_mouse_exited():
	_set_default_text()


func _on_Cheats_mouse_entered():
	$InfoText.text = "Cheats - Press key to activate\n\n\"9\" - Spawn Shooting Star\n\"0\" - Add $10\n\"-\" - Stop Spawning Asteroids\n\"+\" - Increase Wave"


func _on_Cheats_mouse_exited():
	_set_default_text()


func _on_ShootingStar_mouse_entered():
	$InfoText.text = "Shooting Stars\n\n- Randomly fly across screen\n- Collect star to gain $10"


func _on_ShootingStar_mouse_exited():
	_set_default_text()


func _on_ShotgunTower_mouse_entered():
	$InfoText.text = "Multi-Shot Tower\n\n- Shoots 3 lasers in quick succesion\n- Cost $30 to place\n- Battery lasts 15 rounds of shots before dying\n- Can take 3 hits from asteroids before being destroyed"


func _on_ShotgunTower_mouse_exited():
	_set_default_text()


func _on_Missile_mouse_entered():
	$InfoText.text = "Missile\n\n- Drag and drop the crosshair into an open tile to launch a missile and destroy all asteroids in a 3x3 area!\n- Cost $40 per use"


func _on_Missile_mouse_exited():
	_set_default_text()
