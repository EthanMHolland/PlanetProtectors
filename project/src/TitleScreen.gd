extends Node2D

func _on_PlayButton_button_down():
	var _ignored = get_tree().change_scene("res://src/Level.tscn")


func _on_InfoButton_button_down():
	var _ignored = get_tree().change_scene("res://src/InfoScreen.tscn")
