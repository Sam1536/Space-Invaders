extends Node2D
const hiscore_file = "user://hiscore_file"

var pre_name_selector = preload("res://scenes/new_selector.tscn")
var pre_game = preload("res://scenes/game.tscn")
var game 

var hiscores = [
	{name = "AAA" , score = 1000},
	{name = "BBB" , score = 900},
	{name = "CCC" , score = 800},
	{name = "DDD" , score = 700},
	{name = "EEE" , score = 600},
	{name = "FFF" , score = 500},
	{name = "GGG" , score = 400},
	{name = "HHH" , score = 300},
	{name = "III" , score = 200},
	{name = "JJJ" , score = 100}
]

var hiscore

func _ready():
	$hiscore.show_hiscores(hiscores)


func new_game():
	if game != null:
		game.queue_free()
	game = pre_game.instance()
	$game_node.add_child(game)
	game.connect("gamer_over",self,"on_game_gamer_over")
	game.connect("victory",self,"on_victory")

func _on_button_pressed():
	$button.hide()
	$hiscore.hide()
	new_game()

func on_game_gamer_over():
	hiscore = null
	for hs in hiscores:
		if game.data.score > hs.score:
			hiscore = hs
			break
	
	if hiscore != null:
		var name_selector = pre_name_selector.instance()
		add_child(name_selector)
		name_selector.connect("finished", self , "on_name_selector_finished")
		yield(name_selector, "finished")
		name_selector.queue_free()
		save_hiscore()
	
	
	
	$button.show()
	$hiscore.show()
	$hiscore.show_hiscores(hiscores)

func on_victory():
	var data = game.data
	new_game()
	game.data = data
	game.update_hud()


func on_name_selector_finished(val):
	#print(hiscores)
	var index = hiscores.find(hiscore)
	hiscores.insert(index , {name = val, score = game.data.score})
	hiscores.resize(10)
	#print(val)

func save_hiscore():
	var file = File.new()
	var result = file.open(hiscore_file, file.WRITE)
	if result == OK:
		var store_hiscore = {
		hiscores = hiscores
		}
		file.store_string(store_hiscore.to_json())
		file.close()
