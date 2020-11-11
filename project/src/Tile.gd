extends Area2D

signal _laser_tower_placed

var laser_tower := preload("LaserTower.tscn")
var _has_tower := false
var _mouse_overlapping := false

onready var level := get_parent().get_parent()


func _physics_process(_delta):
	_place_tower()
	

func _place_tower():
	if (Input.is_action_just_pressed("place_tower") and _mouse_overlapping == true):
		if !_has_tower:
			if level._money > 0:
				var _new_tower = laser_tower.instance()
				_new_tower.position = Vector2(0,0)
				self.add_child(_new_tower)
				_has_tower = true
				_new_tower.connect("tower_destroyed", self, "_on_tower_destroyed")
				level._money -= 10
			else:
				print("Insufficient money!")
		else:
			print("There is a tower here!")


func _on_tower_destroyed():
	_has_tower = false


func _on_Tile_mouse_entered():
	_mouse_overlapping = true



func _on_Tile_mouse_exited():
	_mouse_overlapping = false

