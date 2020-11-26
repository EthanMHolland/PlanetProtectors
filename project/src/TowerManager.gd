extends Node2D
# laser tower signals
signal select_laser_tower
signal place_laser_tower
#shotgun tower signals
signal select_shotgun_tower
signal place_shotgun_tower

var _dragging_tower := false
var _dragging_tower_last := _dragging_tower

var _dragging_laser_tower := false
var _dragging_laser_tower_last := _dragging_laser_tower

var _dragging_shotgun_tower := false
var _dragging_shotgun_tower_last := _dragging_shotgun_tower

var _mouse_inside_laser : bool
var _mouse_inside_shotgun : bool

func _process(_delta):
	_select_laser_tower()
	_select_shotgun_tower()
		

func _select_laser_tower():
	if Input.is_action_pressed("drag_tower"):
		if _mouse_inside_laser == true:
			_dragging_laser_tower_last = _dragging_laser_tower
			_dragging_laser_tower = true
			emit_signal("select_laser_tower")
		if _dragging_laser_tower == true:
			$CanvasLayer/LaserTower/Sprite.position = get_viewport().get_mouse_position()
	if Input.is_action_just_released("drag_tower"):
		if (_dragging_laser_tower_last == true):
			_dragging_laser_tower = false
			_dragging_laser_tower_last = _dragging_laser_tower
			$CanvasLayer/LaserTower/Sprite.position = Vector2(75, 563)
			emit_signal("place_laser_tower")

func _on_LaserTower_mouse_entered():
	_mouse_inside_laser = true

func _on_LaserTower_mouse_exited():
	_mouse_inside_laser = false

func _select_shotgun_tower():
	if Input.is_action_pressed("drag_tower"):
		if _mouse_inside_shotgun == true:
			_dragging_shotgun_tower_last = _dragging_shotgun_tower
			_dragging_shotgun_tower = true
			emit_signal("select_shotgun_tower")
		if _dragging_shotgun_tower == true:
			$CanvasLayer/ShotgunTower/AnimatedSprite.position = get_viewport().get_mouse_position()
	if Input.is_action_just_released("drag_tower"):
		if (_dragging_shotgun_tower_last == true):
			_dragging_shotgun_tower = false
			_dragging_shotgun_tower_last = _dragging_shotgun_tower
			$CanvasLayer/ShotgunTower/AnimatedSprite.position = Vector2(140, 563)
			emit_signal("place_shotgun_tower")
			

func _on_ShotgunTower_mouse_entered():
	_mouse_inside_shotgun = true


func _on_ShotgunTower_mouse_exited():
	_mouse_inside_shotgun = false
