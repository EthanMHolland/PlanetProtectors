extends Area2D

signal insufficient_money

var laser_tower := preload("LaserTower.tscn")
var shotgun_tower := preload("ShotgunTower.tscn")
var tower_manager := preload("TowerManager.tscn")
var missile := preload("Crosshair.tscn")
var _has_tower := false
var _mouse_overlapping := false
var _tile_selected : bool
var _dragging := false

onready var level := get_parent().get_parent()


func _ready():
	var _new_tower_manager := tower_manager.instance()
	_new_tower_manager.position = Vector2(9999999,999999)
	self.add_child(_new_tower_manager)
	var _ignored = _new_tower_manager.connect("place_laser_tower", self, "_on_place_laser_tower")
	var _ignored2 = _new_tower_manager.connect("place_shotgun_tower", self, "_on_place_shotgun_tower")
	var _ignored3 = _new_tower_manager.connect("dragging", self, "_on_dragging")
	var _ignored4 = _new_tower_manager.connect("not_dragging", self, "_on_not_dragging")
	var _ignored5 = _new_tower_manager.connect("place_missile", self, "_on_place_missile")


func _process(_delta):
	pass


func _place_laser_tower():
	if !_has_tower:
		# checks if the player has enough money
		if level._money >= 10:
			#Spawns in tower
			var _new_tower := laser_tower.instance()
			_new_tower.position = Vector2(0,0)
			self.add_child(_new_tower)
			_has_tower = true
			#Connects "tower destroyed" signal from LaserTower.gd to this script
			var _ignore := _new_tower.connect("tower_destroyed", self, "_on_tower_destroyed")
			level._money -= 10
		else:
			print("Insufficient money!")
			emit_signal("insufficient_money")
			get_parent().get_parent().get_child(14).add_color_override("font_color", Color(255,0,0))
			get_parent().get_parent().get_child(25).start()
	else:
		print("There is a tower here!")


func _place_shotgun_tower():
	if !_has_tower:
		# checks if the player has enough money
		if level._money >= 30:
			#Spawns in tower
			var _new_tower := shotgun_tower.instance()
			_new_tower.position = Vector2(0,0)
			self.add_child(_new_tower)
			_has_tower = true
			#Connects "tower destroyed" signal from LaserTower.gd to this script
			var _ignore := _new_tower.connect("tower_destroyed", self, "_on_tower_destroyed")
			level._money -= 30
		else:
			print("Insufficient money!")
			emit_signal("insufficient_money")
			get_parent().get_parent().get_child(14).add_color_override("font_color", Color(255,0,0))
			get_parent().get_parent().get_child(25).start()
			
			
	else:
		print("There is a tower here!")


func _on_tower_destroyed():
	_has_tower = false
	$TowerDestroyedSound.play()


func _on_Tile_mouse_entered():
	if _dragging == true:
		$Sprite.play("selected")
	_mouse_overlapping = true


func _on_Tile_mouse_exited():
	$Sprite.play("default")
	_mouse_overlapping = false


func _on_place_laser_tower():
	if (_mouse_overlapping == true):
		_place_laser_tower()


func _on_place_shotgun_tower():
	if (_mouse_overlapping == true):
		_place_shotgun_tower()


func _on_place_missile():
	if (_mouse_overlapping == true):
		_place_missile()


func _on_dragging():
	_dragging = true


func _on_not_dragging():
	_dragging = false


func _place_missile():
	if !_has_tower:
		# checks if the player has enough money
		if level._money >= 40:
			#Spawns in tower
			var _new_tower := missile.instance()
			_new_tower.position = Vector2(0,0)
			self.add_child(_new_tower)
			_has_tower = true
			#Connects "tower destroyed" signal from LaserTower.gd to this script
			var _ignore := _new_tower.connect("missile_destroyed", self, "_on_missile_destroyed")
			level._money -= 40
		else:
			print("Insufficient money!")
			emit_signal("insufficient_money")
			get_parent().get_parent().get_child(14).add_color_override("font_color", Color(255,0,0))
			get_parent().get_parent().get_child(25).start()
	else:
		print("There is a tower here!")


func _on_missile_destroyed():
	_has_tower = false
