extends Area2D

var vel = 195
var dir = Vector2(0 , -1)


func _ready():
	add_to_group("ship_shot")
	set_process(true)


func _process(delta):
	translate(dir * vel * delta)
	
	if global_position.y < 0:
		queue_free()


func _on_ship_shot_area_entered(area):
	if  area.has_method("destroy"):
		area.destroy(self)
		destroy(self)

func destroy(obj):
	queue_free()
