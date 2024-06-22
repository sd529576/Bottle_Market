extends Node

var Players = {}
var Bottle_data = {}
var num_players = 0
var on_item = false
var Server_item_data = {}
var offer_number = 0
var item_spacing = 30
var Shiny_Container = []
var host_created = false
var Item_description = {}
var File = "res://Item_Description.txt"
var Price_Tracker = {}


func _ready():
	load_file(File)
	
func load_file(filename):
	var f = FileAccess.open(File,FileAccess.READ)
	var index = 0 
	while not f.eof_reached():
		var line = f.get_line()
		Item_description[index] = line
		index += 1
	f.close()
