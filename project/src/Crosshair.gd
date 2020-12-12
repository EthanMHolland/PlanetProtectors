extends Area2D

signal missile_destroyed

var missile := preload("Missile.tscn")




# Called when the node enters the scene tree for the first time.
func _ready():
	var _new_missile := missile.instance()
	add_child(_new_missile)
	var _ignored = _new_missile.connect("missile_destroyed", self, "_on_missile_destroyed")
	var _ignored2 = _new_missile.connect("detonated", self, "_on_detonated")
	_new_missile.global_position = Vector2(0, self.global_position.y)

func _on_missile_destroyed():
	emit_signal("missile_destroyed")
	queue_free()

func _on_detonated():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite.hide()
