extends CanvasLayer

@export var UI : CanvasLayer

func _on_death_timer_timeout():
	UI.visible = false
	self.visible = true
