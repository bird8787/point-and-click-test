extends Area2D
@export var text:String
@export var textbox = get_parent()
#func _input(event: InputEvent) -> void:
	#if(event.button_mask==1 and event.is_pressed()):
		#print(text)
		#textbox.change_text(text)

func _input_event(viewport,event,shape_idx):
	if(event.button_mask==1 and event.is_pressed()):
		print("text")
		textbox.change_text(text)
