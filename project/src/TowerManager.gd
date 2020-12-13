extends Node2D
# laser tower signals
signal select_laser_tower
signal place_laser_tower
#shotgun tower signals
signal select_shotgun_tower
signal place_shotgun_tower

signal select_missile
signal place_missile

signal dragging
signal not_dragging

var _dragging_tower := false
var _dragging_tower_last := _dragging_tower

var _dragging_laser_tower := false
var _dragging_laser_tower_last := _dragging_laser_tower

var _dragging_shotgun_tower := false
var _dragging_shotgun_tower_last := _dragging_shotgun_tower

var _dragging_missile := false
var _dragging_missile_last := _dragging_missile

var _mouse_inside_laser : bool
var _mouse_inside_shotgun : bool
var _mouse_inside_missile : bool


func _process(_delta):
	_select_laser_tower()
	_select_shotgun_tower()
	_select_missile()


func _select_laser_tower():
	if Input.is_action_pressed("drag_tower"):
		if _mouse_inside_laser == true:
			emit_signal("dragging")
			_dragging_laser_tower_last = _dragging_laser_tower
			_dragging_laser_tower = true
			emit_signal("select_laser_tower")
		if _dragging_laser_tower == true:
			$CanvasLayer/LaserTower/Sprite.position = get_viewport().get_mouse_position()
	if Input.is_action_just_released("drag_tower"):
		if (_dragging_laser_tower_last == true):
			emit_signal("not_dragging")
			_dragging_laser_tower = false
			_dragging_laser_tower_last = _dragging_laser_tower
			$CanvasLayer/LaserTower/Sprite.position = Vector2(35, 558)
			emit_signal("place_laser_tower")


func _on_LaserTower_mouse_entered():
	_mouse_inside_laser = true


func _on_LaserTower_mouse_exited():
	_mouse_inside_laser = false


func _select_shotgun_tower():
	if Input.is_action_pressed("drag_tower"):
		if _mouse_inside_shotgun == true:
			emit_signal("dragging")
			_dragging_shotgun_tower_last = _dragging_shotgun_tower
			_dragging_shotgun_tower = true
			emit_signal("select_shotgun_tower")
		if _dragging_shotgun_tower == true:
			$CanvasLayer/ShotgunTower/AnimatedSprite.position = get_viewport().get_mouse_position()
	if Input.is_action_just_released("drag_tower"):
		if (_dragging_shotgun_tower_last == true):
			emit_signal("not_dragging")
			_dragging_shotgun_tower = false
			_dragging_shotgun_tower_last = _dragging_shotgun_tower
			$CanvasLayer/ShotgunTower/AnimatedSprite.position = Vector2(85, 558)
			emit_signal("place_shotgun_tower")


func _on_ShotgunTower_mouse_entered():
	_mouse_inside_shotgun = true


func _on_ShotgunTower_mouse_exited():
	_mouse_inside_shotgun = false


func _select_missile():
	if Input.is_action_pressed("drag_tower"):
		if _mouse_inside_missile == true:
			emit_signal("dragging")
			_dragging_missile_last = _dragging_missile
			_dragging_missile = true
			emit_signal("select_missile")
		if _dragging_missile == true:
			$CanvasLayer/Missile/Sprite.position = get_viewport().get_mouse_position()
	if Input.is_action_just_released("drag_tower"):
		if (_dragging_missile_last == true):
			emit_signal("not_dragging")
			_dragging_missile = false
			_dragging_missile_last = _dragging_missile
			$CanvasLayer/Missile/Sprite.position = Vector2(135, 558)
			emit_signal("place_missile")


func _on_Missile_mouse_entered():
	_mouse_inside_missile = true


func _on_Missile_mouse_exited():
	_mouse_inside_missile = false
