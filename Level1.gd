extends Node2D

onready var hud = $HUD
onready var menu_layer = $MenuLayer
onready var point = $Point
onready var enemy = $Enemy
onready var strawberry = $Platform/Strawberry

const SAVE_FILE_PATH = "user://savedata.save"

var score = 0 setget set_score
var highscore = 0

func ready():
	strawberry.connect("score",self,player_score())

func new_game():
	self.score = 0
	enemy.start()

func player_score():
	self.score += 1
	point.play()

func set_score(new_score):
	score = new_score
	hud.update_score(score)

func game_over():
	if score > highscore:
		highscore = score
		save_highscore()
	menu_layer.init_game_over_menu(score,highscore)

func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()

func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH,File.READ)
		highscore = save_data.get_var()
		save_data.close()



func _on_MenuLayer_start_game():
	new_game()
