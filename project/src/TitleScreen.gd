extends Node2D

var start_point : Vector2
var end_point : Vector2
var speed := 1.5

func _ready():
	$LaserTower/HealthBar.hide()
	$LaserTower._shots_left = 9999999999
	$Camera2D.position = Vector2(0, 0)

func _on_PlayButton_button_down():
	var _ignored = get_tree().change_scene("res://src/Level.tscn")


func _on_InfoButton_button_down():
#	var _ignored = get_tree().change_scene("res://src/InfoScreen.tscn")
	_move_camera_to_InfoScreen()

func _move_camera_to_InfoScreen():
	start_point = Vector2(0, 0)
	end_point = Vector2(-1023.827,0)
	$Tween.interpolate_property($Camera2D, "position", start_point, end_point, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_InfoScreen_title_button_pressed():
	start_point = Vector2(-1023.827, 0)
	end_point = Vector2(0, 0)
	$Tween.interpolate_property($Camera2D, "position", start_point, end_point, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
