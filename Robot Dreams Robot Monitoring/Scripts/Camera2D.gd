extends Camera2D

@export var Flipbar : Area2D
@export var cams : Node2D
@export var ObservationRoomLit : Sprite2D
@export var ObservationRoomDark : Sprite2D
@export var Lounge : Sprite2D
@export var Kitchen : Sprite2D
@export var Office : Node2D
@export var main : Node2D
@onready var currentCam = ObservationRoomLit
@export var Nocam : Sprite2D
@export var LHall : Sprite2D
@export var RHall : Sprite2D
@export var UI : CanvasLayer
@export var CamSwitch : AudioStreamPlayer

func _ready():
	currentCam.visible = true

func _process(delta):
	self.position = get_local_mouse_position()
	if Flipbar.in_cams == true:
		cams.visible = true
		currentCam.visible = true
		UI.visible = true
	else:
		cams.visible = false
		UI.visible = false
		
func _on_observation_room_pressed():
	if !main.is_intro:
		currentCam.visible = false
		ObservationRoomDark.visible = true
		currentCam = ObservationRoomDark
		CamSwitch.play()
		
func _on_kitchen_pressed():
	if !main.is_intro:
		currentCam.visible = false
		Kitchen.visible = true
		currentCam = Kitchen
		CamSwitch.play()
		
func _on_lounge_pressed():
	if !main.is_intro:
		currentCam.visible = false
		Lounge.visible = true
		currentCam = Lounge
		CamSwitch.play()
	
func _on_hallway_left_pressed():
	if !main.is_intro:
		currentCam.visible = false
		LHall.visible = true
		currentCam = LHall
		CamSwitch.play()

func _on_hallway_right_pressed():
	if !main.is_intro:
		currentCam.visible = false
		RHall.visible = true
		currentCam = RHall
		CamSwitch.play()

func _on_nocam_3_pressed():
	if !main.is_intro:
		currentCam.visible = false
		Nocam.visible = true
		currentCam = Nocam
		CamSwitch.play()

func _on_nocam_2_pressed():
	if !main.is_intro:
		currentCam.visible = false
		Nocam.visible = true
		currentCam = Nocam
		CamSwitch.play()

func _on_nocam_pressed():
	if !main.is_intro:
		currentCam.visible = false
		Nocam.visible = true
		currentCam = Nocam
		CamSwitch.play()

func _on_intro_timer_timeout():
	currentCam.visible = false

func _on_cut_scene_timeout():
	currentCam = ObservationRoomDark
