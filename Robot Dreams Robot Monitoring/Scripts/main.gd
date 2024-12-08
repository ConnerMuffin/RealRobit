extends Node2D

@onready var is_intro = true
@export var OfficeLit : Sprite2D
@export var OfficeNotLit : Sprite2D
@export var flash : AnimationPlayer
@export var MovementTimer : Timer
@export var Lounge : Sprite2D
@export var LDoor : Sprite2D
@export var RDoor : Sprite2D
@export var LHall : Sprite2D
@export var RHall : Sprite2D
@export var Kitchen : Sprite2D
@export var Observe : Sprite2D
@export var NoCam : Sprite2D
@export var Office : Node2D
@export var GameOverScreen : CanvasLayer
@export var UI : CanvasLayer
@export var Phone : AudioStreamPlayer
@export var Death : AudioStreamPlayer
@export var GlassShatter : AudioStreamPlayer
@export var Powerdown : AudioStreamPlayer
@export var Movement1 : AudioStreamPlayer
@export var Movement2 : AudioStreamPlayer
@export var Monitor : AudioStreamPlayer
@export var Flashbeacon : AudioStreamPlayer
@export var Jumpscare : Sprite2D
@export var PowerDown2 : AudioStreamPlayer
@export var DeathTimer : Timer
@export var Cutscene : Timer
@export var Lockdown : AudioStreamPlayer
@export var FlipBar : Area2D
@export var Skip : Button
@export var IntroTimer : Timer
@export var PowerLabel : Label
@export var EnergyInterval : Timer
@export var TimeLabel : Label
@export var Live : Timer
@export var FlashTutorial : Label
@export var Observation : Sprite2D
@export var cams : CanvasLayer
@export var WinScreen : CanvasLayer
@export var Yippie : AudioStreamPlayer
@onready var flash_cool_down = $FlashCoolDown

var Power = 100.0
var Difficulty = RobitDifficulty.Difficulty
@onready var location = Observe
var NoCam3
var NoCam2
@onready var LDoorPower = 0
@onready var RDoorPower = 0
@onready var CameraPower = 0
@onready var total_time_secs = 270
@onready var NoPower = false
@onready var PowerOff = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Flash") and !is_intro and !NoPower and flash_cool_down.is_stopped():
		FlashTutorial.visible = false
		OfficeLit.visible = true
		flash.play("FlashBeacon")
		Flashbeacon.play()
		Power -= 2
		flash_cool_down.start()
		# remove some amount of either power or charges for flashing
	if Phone.playing:
		Skip.visible = true
	else:
		Skip.visible = false
	
	if Office.LDoor == true:
		LDoorPower = 0.2
	else:
		LDoorPower = 0
	
	if Office.LDoor == true:
		RDoorPower = 0.2
	else:
		RDoorPower = 0
	
	if FlipBar.in_cams == true:
		CameraPower = 0.2
	else:
		CameraPower = 0
	
	PowerLabel.text = ("Power: " + str(Power) + "%")
	
	if Power < 1:
		Power = 0
		NoPower = true
		EnergyInterval.stop()
	
	if NoPower == true and PowerOff == false:
		Powerdown.play()
		PowerOff = true
	
	if total_time_secs < 0:
		Yippie.play()
		WinScreen.visible = true
		get_tree().paused = true
	
func _on_intro_timer_timeout():
	cams.visible = false
	is_intro = false
	Powerdown.play()
	Lockdown.play()
	Cutscene.start()
	OfficeLit.visible = false
	location.visible = true
	FlipBar.in_cams = false
	Observation.visible = false
	get_tree().paused = true	
	
func _on_cut_scene_timeout():
	get_tree().paused = false
	MovementTimer.start()
	EnergyInterval.start()
	TimeLabel.visible = true
	Live.start()
	FlashTutorial.visible = true
# robit movement
func _on_movement_opportunites_timeout():
	if Difficulty > randi_range(0, 19):
		if location == NoCam3 or location == NoCam2:
			pass
		else:
			location.visible = false
		location = move(location)
		if location == NoCam3 or location == NoCam2:
			pass
		else:
			location.visible = true
		if 1 == randi_range(1,8):
			if 1 == randi_range(0,1):
				Movement1.play()
			else:
				Movement2.play()
	else:
		pass
		

func move(location):
	var direction = randi_range(1, 4)
	match location:	
		NoCam:
			if direction == 1 or direction == 2:
				return Kitchen
			else:
				return LHall
		NoCam2:
			if direction == 1 or direction == 2:
				return RHall
			else:
				return NoCam3
		NoCam3:
			if direction == 1:
				return NoCam2
			elif direction == 2:
				return Observe
			else:
				return RHall
		Kitchen:
			if direction == 1:
				return Kitchen
			elif direction == 2:
				return Lounge
			else:
				return LHall
		Lounge:
			if direction == 1:
				return Observe
			else:
				return Kitchen
		Observe:
			if randi_range(1, 2) == 1:
				return Lounge
			else: 
				return NoCam3
		LHall:
			if direction == 1:
				return NoCam
			elif direction == 2:
				return Kitchen
			else:
				return LDoor
		RHall:
			if direction == 1:
				return NoCam2
			elif direction == 2:
				return NoCam3
			else:
				return RDoor
		LDoor:
			if !Office.LDoor:
				death()
			else:
				return Observe
		
		RDoor:
			if !Office.RDoor:
				death()
			else:
				return Observe
				
func death():
	get_tree().paused = true
	Death.play()
	Jumpscare.visible = true
	DeathTimer.start()

func _on_skip_pressed():
	Phone.playing = false
	Skip.visible = false
	IntroTimer.emit_signal("timeout")
	IntroTimer.queue_free()
	Skip.visible = false

func _on_energy_depletion_timeout():
	Power -= (0.2 + CameraPower + LDoorPower + RDoorPower)

func _on_live_timeout():
	total_time_secs -= 1
	var m = int(total_time_secs / 60.0)
	var s = total_time_secs - m * 60
	TimeLabel.text = "%02d:%02d" % [m, s]
