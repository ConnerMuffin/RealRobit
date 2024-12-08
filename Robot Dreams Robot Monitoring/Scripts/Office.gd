extends Node2D

@onready var LDoor = false
@onready var RDoor = false
@export var LeftDoor : Sprite2D
@export var RightDoor : Sprite2D
@export var GoodContain : Sprite2D
@onready var main = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if main.NoPower == true:
		LDoor = false
		RDoor = false
	# Door Functions
	if LDoor:
		LeftDoor.visible = true
	else:
		LeftDoor.visible = false
	if RDoor:
			RightDoor.visible = true
	else:
			RightDoor.visible = false


func _on_intro_timer_timeout():
	GoodContain.visible = false
