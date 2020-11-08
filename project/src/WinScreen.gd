extends Node2D


func _on_PlayAgain_button_down():
	var _change_scene = get_tree().change_scene("res://src/Level.tscn")


func _on_MainMenu_button_down():
	var _change_scene = get_tree().change_scene("res://src/TitleScreen.tscn")
