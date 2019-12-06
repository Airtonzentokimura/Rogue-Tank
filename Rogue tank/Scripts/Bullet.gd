extends Area2D

#numero que nunca muda de distancia.
const MAX_DIST = 250

var vel = 250
#setget e utilizado para pegar as defincoes de uma funcao
var dir = Vector2(0,-1) setget set_dir
#variável para vivo ligada como verdadeiro
var live = true
#variavel que marca posicao
onready var init_pos = global_position

func _ready():
	
	pass
	
func _process(delta):
	
	if live:
	# se a minha posicao (global position) ate a distancia (distance to a b) foi maior que 250
		if global_position.distance_to(init_pos) >= MAX_DIST:
		
		#$ = patio ou nó smoke .emitting= continuar animação
			$Smoke.emitting = false
		#vivo sera falso e nao ira se movimentar
			live = false
		#$ = patio ou no Sprite .visible = visibilidade (desenho nao sera visivel)
			$Sprite.visible = false
		#monitoring = colisão false = desligado monitorable = colisão
			monitoring = false
			monitorable = false
		#$ = patio ou no Anim_self_destruction .play = faz a animação "explode" nome da animação
			$Anim_self_destruction.play("explode")
		# yield = de preferencia a e espere a execucao (argumento 1 que e o patio ou no , argumento 2 sinal do no ou patio)
			yield($Anim_self_destruction , "animation_finished")
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