extends Button
@onready var controls_container: VBoxContainer = $"../../Controls Container"
@onready var visuals_container: VBoxContainer = $"../../Visuals Container"
@onready var audio_container: VBoxContainer = $"../../Audio Container"

func _on_pressed() -> void:
	
	if controls_container.visible:
		controls_container.visible = false
	elif !controls_container.visible:
		controls_container.visible = true
		visuals_container.visible = false
		audio_container.visible = false
