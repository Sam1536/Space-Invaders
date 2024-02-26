extends HBoxContainer


var pos = "1ST" setget set_pos
var names = "AAA" setget set_names
var score = "9999" setget set_score
var color = Color(1,1,1,1) setget set_color

func set_pos(val):
	pos = val
	$pos.set_text(str(val))

func set_names(val):
	names = val
	$name.set_text(str(val))
	
func set_score(val):
	score = val
	$score.set_text(str(val))

func set_color(val):
	color = val
	$pos.set("custom_colors/font_color" , color)
	$name.set("custom_colors/font_color" , color)
	$score.set("custom_colors/font_color" , color)
