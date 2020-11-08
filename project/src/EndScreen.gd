extends Node2D


func _on_PlayAgainButton_button_down():
	var _change_scene = get_tree().change_scene("res://src/Level.tscn")


func _on_MainMenuButton_button_down():
	var _change_scene = get_tree().change_scene("res://src/TitleScreen.tscn")
