extends Node

var player_one_score = 0
var player_two_score = 0
var score_label_p1
var score_label_p2

func _ready():
	score_label_p1 = get_node("UI/HBox/ScoreP1")
	score_label_p2 = get_node("UI/HBox/ScoreP2")
	
func _process(delta):
	score_label_p1.text = "%d" % player_one_score
	score_label_p2.text = "%d" % player_two_score
