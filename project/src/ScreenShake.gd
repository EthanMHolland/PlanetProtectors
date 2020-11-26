extends Node2D

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var _amplitude := 0
var _priority := 0

onready var _camera = get_parent()

func _start(duration = 0.2, frequency = 15, amplitude = 2, priority = 0):
	if _priority >= priority:
		_amplitude = amplitude
		_priority = priority
		
		$Duration.wait_time = duration
		$Frequency.wait_time = 1 / float(frequency)
		$Duration.start()
		$Frequency.start()
		
		_new_shake()


func _new_shake():
	var _rand = Vector2()
	_rand.x = rand_range(-_amplitude, _amplitude)
	_rand.y = rand_range(-_amplitude, _amplitude)
	
	$ShakeTween.interpolate_property(_camera, "offset", _camera.offset, _rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func _reset():
	$ShakeTween.interpolate_property(_camera, "offset", _camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()
	
	_priority = 0

func _on_Frequency_timeout():
	_new_shake()


func _on_Duration_timeout():
	_reset()
	$Frequency.stop()
