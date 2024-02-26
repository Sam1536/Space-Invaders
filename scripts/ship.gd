extends Area2D

var vel = 200
var lazer
var pre_shot = preload("res://scenes/ship_shot.tscn")
var pre_lazer = false

var alive = true  

signal destroyed
signal respawn

func _ready():
	#set_process(true)
	hide()
	

func _process(delta):
	 var dirx = 0
	 var diry = 0

	 if Input.is_action_pressed("ui_right"):
			  dirx = 1

	 if Input.is_action_pressed("ui_left"):
			  dirx -= 1
			
	 if Input.is_action_pressed("ui_up"):
			  diry = -1	
		
	 if Input.is_action_pressed("ui_down"):
			  diry = 1		
		
	 lazer = Input.is_action_pressed("disparo")
	 

	
	 translate(Vector2(dirx , diry) * vel * delta)
	 
	 global_position.x = clamp(global_position.x , 8 , 172)
	 global_position.y = clamp(global_position.y , 4 , 316) 

	 #print(lazer)
	
	 if lazer and not pre_lazer and get_tree().get_nodes_in_group("ship_shot").size() < 4:
		 $audio2.play()	
		 var s = pre_shot.instance()
		 get_parent().add_child(s)
		 s.global_position = global_position
		
		 
	 pre_lazer = lazer

func start():
	show()
	set_process(true)


func disable():
	hide()
	set_process(false)
	alive = false 
	

func destroy(obj):
	$audio.play()
	if alive:
		alive = false 
		set_process(false) 
		emit_signal("destroyed")
		$anim.play("dead")
		yield($anim , "animation_finished" )
		emit_signal("respawn")
		set_process(true)
		alive = true
		$sprite.set_frame(0)
