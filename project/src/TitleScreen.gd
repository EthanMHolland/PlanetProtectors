extends Node2D

var start_point : Vector2
var end_point : Vector2
var speed := 1.5
var alt_speed := 4

func _ready():
	$LaserTower._shots_left = 9999999999
	$Camera2D.position = Vector2(0, 0)
	
func _on_PlayButton_button_down():
	_move_camera_to_Level()


func _on_InfoButton_button_down():
#	var _ignored = get_tree().change_scene("res://src/InfoScreen.tscn")
	_move_camera_to_InfoScreen()

func _move_camera_to_InfoScreen():
	start_point = Vector2(0, 0)
	end_point = Vector2(-1024,0)
	$Tween.interpolate_property($Camera2D, "position", start_point, end_point, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_InfoScreen_title_button_pressed():
	start_point = Vector2(-1024, 0)
	end_point = Vector2(0, 0)
	$Tween.interpolate_property($Camera2D, "position", start_point, end_point, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _move_camera_to_Level():
	start_point = Vector2(0, 0)
	end_point = Vector2(1500, 0)
	$LevelTween.interpolate_property($Camera2D, "position", start_point, end_point, alt_speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$LevelTween.start()

func _on_LevelTween_tween_all_completed():
	var _ignored = get_tree().change_scene("res://src/Level.tscn")
