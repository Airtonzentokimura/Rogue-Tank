extends KinematicBody2D

#Velocidade do tiro
var speed = 100
#Variavel que pré carrega uma cena para ser utilizado
var pre_bullet = preload("res://scenes/Bullet.tscn")
#variaveis para trocar a sprite das skins. Export para criar a aba de variaveis. int entre aspas para nomear a lista.
export (int, "Big Red", "Blue", "Dark", "Dark Large", "Green", "huge", "Red", "Sand") var bodie = 0
export var barrel = 3



#lista com as skins (lembrar de sempre popular a lista "colocar os itens")
var bodies = [ 
	"res://sprites/tankBody_bigRed.png", #indice0
	"res://sprites/tankBody_blue.png", #indice 1
	"res://sprites/tankBody_dark.png",
	"res://sprites/tankBody_darkLarge.png",
	"res://sprites/tankBody_green.png",
	"res://sprites/tankBody_huge.png",
	"res://sprites/tankBody_red.png",
	"res://sprites/tankBody_sand.png",
]

var barrels = [
	"res://sprites/specialBarrel1.png",
	"res://sprites/specialBarrel2.png",
	"res://sprites/specialBarrel3.png",
	"res://sprites/specialBarrel4.png",
	"res://sprites/specialBarrel5.png",
	"res://sprites/specialBarrel6.png",
	"res://sprites/specialBarrel7.png",
	"res://sprites/tankBlue_barrel1.png",
	"res://sprites/tankBlue_barrel2.png",
	"res://sprites/tankBlue_barrel3.png",
	"res://sprites/tankDark_barrel1.png",
	"res://sprites/tankDark_barrel2.png",
	"res://sprites/tankDark_barrel3.png",
	"res://sprites/tankGreen_barrel1.png",
	"res://sprites/tankGreen_barrel2.png",
	"res://sprites/tankGreen_barrel3.png",
	"res://sprites/tankRed_barrel1.png",
	"res://sprites/tankRed_barrel2.png",
	"res://sprites/tankRed_barrel3.png",
	"res://sprites/tankSand_barrel1.png",
	"res://sprites/tankSand_barrel2.png",
	"res://sprites/tankSand_barrel3.png",
]

func _ready():
	$Sprite.texture = load(bodies[bodie])
	$Barrel/Sprite.texture = load(barrels[barrel])
	pass 

 
func _process(delta):
	var dir_x = 0
	var dir_y = 0
	
	if Input.is_action_pressed("ui_right"):
		dir_x += 1
	if Input.is_action_pressed("ui_left"):
		dir_x -= 1
	if Input.is_action_pressed("ui_up"):
		dir_y -= 1
	if Input.is_action_pressed("ui_down"):
		dir_y += 1
	if Input.is_action_just_pressed("ui_shoot"):
		#Funcao que limita o numero de balas
		if get_tree().get_nodes_in_group("Cannon_bullets").size() < 30:
			#Adicionar a variavel bullet e puxando os dados para ser utilizado do pre-scene	
			var bullet = pre_bullet.instance()
			#Local e posição que ira sair a imagem 
			bullet.global_position = $Barrel/Muzzle.global_position
			#Direcao da bala
			bullet.dir = Vector2(cos(rotation),sin(rotation)).normalized()
			#Adiciona a animação na cena
			get_parent().add_child(bullet)
			$Barrel/AnimationPlayer.play("Fire")
	
	look_at(get_global_mouse_position())
	
	translate(Vector2(dir_x,dir_y) * delta * speed )
	
	pass
