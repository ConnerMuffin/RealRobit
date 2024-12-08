extends Node2D

var Greenbutton = load("res://Scenes/L_button_green.tscn")
@onready var left_open = $"../../LeftOpen"
@onready var office = $".."
@onready var main = $"../.."

func _on_button_pressed():
	if main.NoPower == false:
		var NewButton = Greenbutton.instantiate()
		NewButton.position = self.position
		office.add_child(NewButton)
		office.LDoor = false
		left_open.play()
		self.queue_free()
