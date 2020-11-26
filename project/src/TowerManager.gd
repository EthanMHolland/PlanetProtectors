extends Node2D

signal select_laser_tower
signal place_laser_tower

var laser_tower := preload("LaserTower.tscn")
var _dragging_tower := false
var _dragging_tower_last := _dragging_tower
var _mouse_inside_laser : bool


func _process(_delta):
	_select_laser_tower()
		


func _select_laser_tower():
	if Input.is_action_pressed("drag_tower"):
		if _mouse_inside_laser == true:
			_dragging_tower_last = _dragging_tower
			_dragging_tower = true
			emit_signal("select_laser_tower")
		if _dragging_tower == true:
			$CanvasLayer/LaserTower/Sprite.position = get_viewport().get_mouse_position()
	if Input.is_action_just_released("drag_tower"):
		if (_dragging_tower_last == true):
			_dragging_tower = false
			_dragging_tower_last = _dragging_tower
			$CanvasLayer/LaserTower/Sprite.position = Vector2(271, 563)
			emit_signal("place_laser_tower")
			print("place_laser_tower")

func _on_LaserTower_mouse_entered():
	_mouse_inside_laser = true

func _on_LaserTower_mouse_exited():
	_mouse_inside_laser = false
