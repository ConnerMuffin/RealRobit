extends Node2D

var Redbutton = load("res://Scenes/R_button_red.tscn")
@onready var right_close = $"../../RightClose"
@onready var office = $".."
@onready var main = $"../.."

func _on_button_pressed():
	if main.NoPower == false:
		var NewButton = Redbutton.instantiate()
		NewButton.position = self.position
		office.add_child(NewButton)
		office.RDoor = true
		right_close.play()
		self.queue_free()

