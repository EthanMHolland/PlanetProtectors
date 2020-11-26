extends Area2D

var laser_tower := preload("LaserTower.tscn")
var tower_manager := preload("TowerManager.tscn")
var _has_tower := false
var _mouse_overlapping := false
var _tile_selected : bool

onready var level := get_parent().get_parent()

func _ready():
	var _new_tower_manager := tower_manager.instance()
	_new_tower_manager.position = Vector2(9999999,999999)
	self.add_child(_new_tower_manager)
	var _ignored = _new_tower_manager.connect("place_laser_tower", self, "_on_place_laser_tower")

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
	else:
		print("There is a tower here!")


func _on_tower_destroyed():
	_has_tower = false
	$TowerDestroyedSound.play()


func _on_Tile_mouse_entered():
	_mouse_overlapping = true

func _on_Tile_mouse_exited():
	_mouse_overlapping = false

func _on_place_laser_tower():
	print("signal recieved")
	if (_mouse_overlapping == true):
		print("mouse_overlapping and placing")
		_place_laser_tower()

