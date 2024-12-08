extends Node2D

var Redbutton = load("res://Scenes/L_button_red.tscn")
@onready var left_close = $"../../LeftClose"
@onready var office = $".."
@onready var main = $"../.."

func _on_button_pressed():
	if main.NoPower == false:
		var NewButton = Redbutton.instantiate()
		NewButton.position = self.position
		office.add_child(NewButton)
		office.LDoor = true
		left_close.play()
		self.queue_free()
