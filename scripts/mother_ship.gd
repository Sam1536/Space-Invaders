extends Area2D

signal destroyed(obj)

var score = 200

func _ready():
	$audio.play()
	$move.play("move")
	yield($move , "animation_finished")
	queue_free()


func destroy(obj):
	emit_signal("destroyed",self)
	queue_free()
