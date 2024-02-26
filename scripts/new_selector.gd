extends Node2D

const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ_#*1234567890"

var index = 0
var letter = 0

signal finished(name)

func _ready():
	set_process_input(true)
	

func _input(event):
	var alterou = false
	
	if event.is_action_pressed("ui_right") and not event.is_echo():
		index += 1
		alterou = true
		
	
	if event.is_action_pressed("ui_left") and not event.is_echo():
		index -= 1
		alterou = true
		
	if alterou:
		if index < 0 :
			index = letters.length() - 1
		elif index >= letters.length():
			index = 0	
		$containe.get_child(letter).set_text(letters[index])
	 
	if event.is_action_pressed("disparo") and not event.is_echo():
		#$containe.get_child(letter).set_opacity(1)
		index = 0
		letter += 1
		if letter > 2:
		   $timer.stop()
		   set_process_input(false)
		   var name = $containe.get_child(0).get_text() + $containe.get_child(1).get_text() + $containe.get_child(2).get_text()
		   emit_signal("finished" , name)
		   #print(name)
 
func _on_timer_timeout():
	if $containe.get_child(letter).get_opacity() > 0:
		 $containe.get_child(letter).set_opacity(0)
	else:
		 $containe.get_child(letter).set_opacity(1)
			
