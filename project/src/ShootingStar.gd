extends RigidBody2D

export var min_speed = 125 # minimum speed range
export var max_speed = 200 # maximum speed range

signal star_grabbed

func _ready():
	$Sprite.play("default")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _twinkle():
	linear_velocity = Vector2.ZERO
	$Sprite.play("twinkle")
	$TwinkleSound.play()
	emit_signal("star_grabbed")


func _on_ShootingStar_input_event(_viewport, _event, _shape_idx):
	if _event is InputEventMouseButton:
		if _event.is_pressed():
			_twinkle()


func _on_Sprite_animation_finished():
	if $Sprite.animation == "twinkle":
		queue_free()