extends Node2D

const vel = Vector2(6,0)

var pre_alien_shot = preload("res://scenes/alien_shot.tscn")
var pre_alien_explosion = preload("res://scenes/alien_explosion.tscn")
var pre_mother_ship =  preload("res://scenes/mother_ship.tscn")

var dir = 1

signal enemy_down(obj)
signal readyy
signal earth_dominated
signal victory

func _ready():
	#get_node("timer_shot").start()
	restart_time_mother_ship()
	for aliens in get_node("aliens").get_children():
		aliens.hide()
		aliens.connect("destroyed" , self , "on_aliens_destroied")
	
	for aliens in get_node("aliens").get_children():
		$timer_pause.start()
		yield($timer_pause , "timeout")
		aliens.show()
	emit_signal("readyy")
	start_all()

func shoot():
	var n_aliens = get_node("aliens").get_child_count()
	if n_aliens > 0:
		 var aliens = get_node("aliens").get_child(randi() % n_aliens)
		 var aliens_shot = pre_alien_shot.instance()
		 get_parent().add_child(aliens_shot)
		 aliens_shot.global_position = aliens.global_position
	

func _on_tomer_shot_timeout():
	get_node("timer_shot").set_wait_time(rand_range(.5 , 2))
	shoot()


func _on_timer_move_timeout():
	
	$audio.play()
	
	var borde = false
	
	for aliens in get_node("aliens").get_children():
		aliens.next_frame()
		if aliens.global_position.x > 170 and dir > 0:
			dir = -1
			borde = true	
		if aliens.global_position.x < 10 and dir < 0:
			dir = 1
		
		if aliens.global_position.y > 267:
			emit_signal("earth_dominated")
		
		
	if borde:
		translate(Vector2(0,8))
		if get_node("timer_move").get_wait_time() > .11:
			get_node("timer_move").set_wait_time(get_node("timer_move").get_wait_time() - .1)
	else:
		translate(vel * dir)


func on_aliens_destroied(aliens):
	emit_signal("enemy_down" , aliens)
	var alien_explo = pre_alien_explosion.instance()
	get_parent().add_child(alien_explo)
	alien_explo.position = aliens.global_position
	if $aliens.get_child_count() == 1:
		stop_all()
		emit_signal("victory")

func _on_timer_mother_ship_timeout():
	var mother_ship = pre_mother_ship.instance()
	mother_ship.connect("destroyed" , self , "on_aliens_destroied")
	get_parent().add_child(mother_ship)
	restart_time_mother_ship()

func restart_time_mother_ship():
	get_node("timer_mother_ship").set_wait_time(rand_range(6 , 18))
	get_node("timer_mother_ship").start()

func stop_all():
		get_node("timer_mother_ship").stop()
		get_node("timer_shot").stop()
		get_node("timer_move").stop()

func start_all():
		get_node("timer_mother_ship").start()
		get_node("timer_shot").start()
		get_node("timer_move").start()
	
