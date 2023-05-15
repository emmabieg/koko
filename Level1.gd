extends Node2D

signal level_completed

onready var hud = $HUD
onready var score_label = $HUD/Score
onready var menu_layer = $MenuLayer
onready var enemy = $Enemy
onready var enemy2 = $Enemy2
onready var enemy3 = $Enemy3
onready var finish = $Finish
onready var koko = $Koko

const SAVE_FILE_PATH = "user://savedata.save"

var highscore = 0

func _ready():
	koko.connect("scoreHit",self,"player_unscore")
	connect("level_completed",koko,"stop")
	finish.connect("finished",self,"level_up")
		

func _process(delta):
	var score = ScoreManager.score
	hud.update_score(score)

func _on_score_updated(new_score):
	# Hier kannst du den erhaltenen Score-Wert im HUD aktualisieren
	hud.update_score(new_score)

	
func new_game():
	ScoreManager.score = 0
	enemy.start()
	enemy2.start()
	enemy3.start()
	
	print("new game")

func player_score():
	ScoreManager.score += 1
	_on_score_updated(ScoreManager.score)

func player_unscore():
	if ScoreManager.score>0:
		ScoreManager.score -= 1
	_on_score_updated(ScoreManager.score)

func level_up():
	emit_signal("level_completed")
	if ScoreManager.score > highscore:
		highscore = ScoreManager.score
		save_highscore()
	menu_layer.init_game_over_menu(ScoreManager.score,highscore)

func _on_MenuLayer_start_game():
	new_game()

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
