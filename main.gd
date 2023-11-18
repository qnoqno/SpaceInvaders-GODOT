extends Node2D




func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Game/Game.tscn")

func _on_leaderboard_pressed():
	get_tree().change_scene_to_file("res://Leaderboard/Leaderboard.tscn")


func _on_rules_pressed():
	get_tree().change_scene_to_file("res://Rules/Rules.tscn")



