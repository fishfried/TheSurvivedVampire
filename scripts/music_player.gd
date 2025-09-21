extends AudioStreamPlayer

func _ready() -> void:
	finished.connect(on_finished)
	$Timer.timeout.connect(on_time_timeout)
	
func on_finished():
	$Timer.start()
	
func on_time_timeout():
	play()
