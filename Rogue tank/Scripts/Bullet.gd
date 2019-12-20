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
#
func _process(delta):
	
	if live:
	# se a minha posicao (global position) ate a distancia (distance to a b) foi maior que 250
		if global_position.distance_to(init_pos) >= MAX_DIST:
	#chama essa funcao chamada auto destroy que foi criada abaixo
			autodestroy()
		
		
		translate(dir*vel*delta)
	
	
#função da saida de objeto
func _on_VisibilityNotifier2D_screen_exited():
	#funcao que dele quando sai da tela
	queue_free()
	
func set_dir(val):
	dir=val
	rotation=dir.angle()

#metodo quando entrar um objeto na area
func _on_Bullet_body_entered(body):
	#se o layer de colisao for igual a 4 que e o numero da layer do muro (conferir o layer clicando no objeto e na aba colisao no inspector)
	if body.collision_layer == 4: 
		autodestroy()

#funcao criada que se chama autodestroy: não existia esse bicho
func autodestroy():
#$ = patio ou nó smoke .emitting= continuar animação
		$Smoke.emitting = false
	#vivo sera falso e nao ira se movimentar
		live = false
	#$ = patio ou no Sprite .visible = visibilidade (desenho nao sera visivel)
		$Sprite.visible = false
		#call_deferred = chama a funcao depois de terminar a funcao principal
		call_deferred("set_monitoring", false)
	#monitoring = colisão false = desligado monitorable = colisão
		call_deferred("set_monitorable",false)
	#$ = patio ou no Anim_self_destruction .play = faz a animação "explode" nome da animação
		$Anim_self_destruction.play("explode")
	# yield = de preferencia a e espere a execucao (argumento 1 que e o patio ou no , argumento 2 sinal do no ou patio)
		yield($Anim_self_destruction , "animation_finished")
	#autodestroi
		queue_free()