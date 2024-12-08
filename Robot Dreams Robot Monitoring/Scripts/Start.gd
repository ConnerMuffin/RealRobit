extends Button

@export var text_edit : LineEdit
@export var try_again : Label
var Difficulty


func _on_pressed():
	if int(text_edit.text) < 21:
		Difficulty = int(text_edit.text)
		RobitDifficulty.Difficulty = Difficulty
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
	else:
		try_again.visible = true
