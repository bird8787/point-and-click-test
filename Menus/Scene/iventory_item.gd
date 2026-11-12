extends Panel

@onready var item_image: Sprite2D = $Control/ItemImage
@onready var name_label: Label = $NameLabel
@onready var quantity_label: Label = $QuantityLabel

@onready var diologue_path: String

func showItem(imagePath: String, Name: String, Quantity: int, DiologuePath: String):
	item_image.texture = load(imagePath)
	item_image.scale = Vector2(124, 124) / item_image.texture.get_size()
	name_label.text = "--"+Name+"--"
	quantity_label.text = "--"+str(Quantity)+"--"
	diologue_path = DiologuePath
	
	
	pass


func _on_on_item_click_pressed() -> void:
	if ResourceLoader.exists(diologue_path):
		Dialogic.start(diologue_path)
	else:
		assert("No such diologue path: ", diologue_path)
	pass # Replace with function body.
