extends Area2D

#numero que nunca muda de distancia.
const MAX_DIST = 250

var vel = 250
#setget e utilizado para pegar as defincoes de uma funcao
var dir = Vector2(0,-1) setget set_dir
#variavel que marca posicao
onready var init_pos = global_position

func _ready():
	
	pass
	
func _process(delta):
	# se a minha posicao (global position) ate a distancia (distance to a b) foi maior que 250
	if global_position.distance_to(init_pos) >= MAX_DIST:
	#autodestroi
		queue_free()
	
	translate(dir*vel*delta)
	
	
#função da saida de objeto
func _on_VisibilityNotifier2D_screen_exited():
	#funcao que dele quando sai da tela
	queue_free()
	
func set_dir(val):
	dir=val
	rotation=dir.angle()