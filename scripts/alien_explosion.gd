extends Node2D


func _ready():
	$audio.play()
	$anim.play("explosion")
	yield($anim , "animation_finished")#(get_node("anim"), "finished")
	queue_free()
