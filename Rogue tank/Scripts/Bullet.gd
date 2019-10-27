extends Area2D

var vel = 250
#setget e utilizado para pegar as defincoes de uma funcao
var dir = Vector2(0,-1) setget set_dir

func _ready():
	pass
	
func _process(delta):
	translate(dir*vel*delta)
	
	


#função da saida de objeto
func _on_VisibilityNotifier2D_screen_exited():
	#funcao que dele quando sai da tela
	queue_free()
	
func set_dir(val):
	dir=val
	rotation=dir.angle()