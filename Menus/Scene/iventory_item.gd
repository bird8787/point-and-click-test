extends Panel

@onready var item_image: Sprite2D = $Control/ItemImage
@onready var name_label: Label = $NameLabel
@onready var quantity_label: Label = $QuantityLabel


func showItem(imagePath: String, Name: String, Quantity: int):
	item_image.texture = load(imagePath)
	item_image.scale = Vector2(124, 124) / item_image.texture.get_size()
	name_label.text = "--"+Name+"--"
	quantity_label.text = "--"+str(Quantity)+"--"
	
	
	pass
