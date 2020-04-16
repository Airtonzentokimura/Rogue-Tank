extends Node2D




func _on_timer_queue_timeout():
	#matar a animacao e colocar na espera
	queue_free()
