extends Node2D

var Greenbutton = load("res://Scenes/R_button_green.tscn")
@onready var right_open = $"../../RightOpen"
@onready var office = $".."
@onready var main = $"../.."

func _on_button_pressed():
	if main.NoPower == false:
		var NewButton = Greenbutton.instantiate()
		NewButton.position = self.position
		office.add_child(NewButton)
		office.RDoor = false
		right_open.play()
		self.queue_free()
