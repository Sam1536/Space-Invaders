tool
extends Area2D

export(int , "A , B , C") var tipo = 0 setget set_tipo

var frame = 0 

var score = 0

signal destroyed(obj)

var atributos = [
	{
		texture = preload("res://space_invaders/Assets/sprites/InvaderA_sheet.png"),
		score = 10
	},
	{ 
		texture = preload("res://space_invaders/Assets/sprites/InvaderB_sheet.png"),
		score = 20
	},
	{
		texture = preload("res://space_invaders/Assets/sprites/InvaderC_sheet.png"),
		score = 30
	}
	
]

func _ready():
	pass

func _draw():	
	var atributo = atributos[tipo]
	get_node("sprite").set_texture(atributo.texture)
	score = atributo.score


func set_tipo(val):
	tipo = val
	if Engine.editor_hint:
		update()

func destroy(obj):
	emit_signal("destroyed" , self)
	queue_free()

func next_frame():
	if frame == 0:
		frame = 1
	else:
		frame = 0	
	get_node("sprite").set_frame(frame)	
		


func _on_enemie_area_entered(area):
	if area.has_method("destroy"):
		area.destroy(self)
