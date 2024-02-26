extends VBoxContainer


const pre_item = preload("res://scenes/score_items.tscn" )

const positions = ["1TS" , "2ND" , "3RD" , "4TH" ,  "5TH" ,  "6TH" ,  "7TH" ,  "8TH" ,  "9TH" ,  "10TH" ]
const colors = ["ff0505","f7ff06","0200ff","0dfff9","ff00d1","eb00ff","00ff46","ffc500","39631d","786cb0"]

func _ready():
	#test()
	pass
	
func test():
	for a in range(10):
		var item = pre_item.instance()
		item.pos = positions[a]
		item.name = str(a) + "AA"
		add_child(item)
		$timer.start()
		yield($timer, "timeout")
	
func show_hiscores(hiscore):
#	for b in get_children():
#		if b extends HBoxContainer
#			b.queue_free()

	var item = pre_item.instance()
	item.pos = "RANK"
	item.name = "NAME"
	item.score = "SCORE"
	add_child(item)
	
	var a = 0
	for hs in hiscore:
		item = pre_item.instance()
		item.pos = positions[a]
		item.name = hs.name
		item.score = hs.score
		item.color = Color(colors[a])
		add_child(item)
		$timer.start()
		yield($timer, "timeout")
		a += 1
