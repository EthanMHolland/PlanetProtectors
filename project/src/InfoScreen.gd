extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_default_text()


func _on_LaserTower_mouse_entered():
	$InfoText.text = "Laser Tower\n\n- Cost $10 to place\n- Battery lasts for 15 shots before dying\n- Can take 3 hits from asteroids before being destroyed"


func _set_default_text():
	$InfoText.text = "Welcome to Planet Protectors!\nThere are asteroids heading toward Earth and we need your help to stop them!\n\n- Drag and drop towers in the grid to fight back!\n- Catch Shooting Stars for extra money!\n- Beat Wave 15 to win!\n\nGood Luck!"


func _on_BackButton_button_down():
	var _ignored = get_tree().change_scene("res://src/TitleScreen.tscn")


func _on_Asteroid_mouse_entered():
	$InfoText.text = "Asteroid\n\n- Can take 1 hit from a Laser or Tower before being destroyed\n- Speed increases with wave count"
	

func _on_LaserTower_mouse_exited():
	_set_default_text()


func _on_Asteroid_mouse_exited():
	_set_default_text()


func _on_Cheats_mouse_entered():
	$InfoText.text = "Cheats - Press button to activate\n\n\"9\" - Spawn Shooting Star\n\"0\" - Add $10\n\"-\" - Stop Spawning Asteroids\n\"+\" - Increase Wave"


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
