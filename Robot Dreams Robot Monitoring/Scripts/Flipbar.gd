extends Area2D

var in_cams = false
@onready var main = $".."

func _on_mouse_entered():
	if main.NoPower == false:
		if in_cams:
			in_cams = false
		else:
			in_cams = true
