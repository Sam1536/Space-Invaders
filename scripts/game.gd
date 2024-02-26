extends Node2D

const extra_life_point = [5000 , 8000 , 10000]


var data = {
	extra_lifes_index = 0,
	score = 0,
	life = 3,
} setget set_data


signal gamer_over
signal victory

func _ready():
	randomize()
	get_node("alien_group").connect("enemy_down" , self , "on_alien_group_enemy_down")	
	get_node("alien_group").connect("readyy" , self , "on_alien_group_readyy")
	get_node("alien_group").connect("earth_dominated" , self , "on_alien_group_earth_dominated")	
	get_node("alien_group").connect("victory" , self , "on_alien_group_victory")
	$ship.connect("destroyed" , self , "on_ship_destroyed")	
	$ship.connect("respawn" , self , "on_ship_respawn")
	
func on_alien_group_enemy_down(aliens):
	data.score += aliens.score
	if data.extra_lifes_index < extra_life_point.size() and data.score >= extra_life_point[data.extra_lifes_index]:
		data.life += 1
		update_life()
		data.extra_lifes_index += 1
	update_score()

func on_alien_group_victory():
	$alien_group.stop_all()
	$ship.disable()	
	emit_signal("victory")


func on_alien_group_readyy():
	$ship.start()

func on_alien_group_earth_dominated():
	gamer_over()

func update_score():
	$HUD/label.set_text(str(data.score))

func update_life():
	$HUD/life_draw.lifes = data.life

func update_hud():
	update_score()
	update_life()
	

func on_ship_destroyed():
	$alien_group.stop_all()
	data.life -=  1
	update_life()
	get_tree().call_group("alien_shot" , "destroy" , self)
	
func on_ship_respawn():
	$alien_group.start_all()
	if data.life <= 0:
		gamer_over()
	else:
		$alien_group.start_all()

func gamer_over():
	$alien_group.stop_all()
	$ship.disable()
	$ship.queue_free()
	emit_signal("gamer_over")

func set_data(val):
	data = val
	update_hud()
