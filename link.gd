extends Area2D
@export var house_scene: PackedScene
@onready var arrow = load("res://icon.svg")
@onready var caine = load("res://pexels-jvdm-1457842.jpg")
func _input_event(viewport,event,shape_idx):
	#print(event)
	if(event.button_mask==1 and event.is_pressed()):
		print("sucess")
		get_tree().change_scene_to_packed(house_scene)


#func _on_area_entered(area: Area2D) -> void:
	#print("AHHHHHHHHH")
	#if (%mouse_collider == area):
		#print("its the one you think it is")
		#Input.set_custom_mouse_cursor(arrow)
		#
#
#func _on_area_exited(area: Area2D) -> void:
	#Input.set_custom_mouse_cursor(caine)
	#print("it's tv time")
