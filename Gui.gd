extends Control

#inventory
@onready var inventoryLabel: RichTextLabel = $Inventory


#puzzlePieces
@onready var puzzlePiece1: ColorRect = $Inventory/GridContainer/ColorRect
@onready var puzzlePiece2: ColorRect = $Inventory/GridContainer/ColorRect2
@onready var puzzlePiece3: ColorRect = $Inventory/GridContainer/ColorRect3
@onready var puzzlePiece4: ColorRect = $Inventory/GridContainer/ColorRect4
#colors
@onready 	var colors = ["#00000000","#ffffffff"]

@onready var rooms = [
	"res://Rooms/outSide.tscn",
	"res://Rooms/insideHouse.tscn"

]

func getJsonAsDict(PATH: String):
	var file = FileAccess.open(PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			return(data_received)
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

func autoSave():
	var PATH = "user://saveState.json"
	var json_string = inventory
	var save_state = getJsonAsDict("user://saveState.json")
	var file = FileAccess.open(PATH, FileAccess.WRITE_READ)
	print(save_state)
	save_state["inventory"] = json_string
	
	var scene_path = get_parent().get_scene_file_path()
	print(rooms.find(scene_path, 0))
	print(scene_path)
	save_state["room"] = rooms.find(scene_path, 0)
	file.store_string(JSON.stringify(save_state))
	pass

func addItemToInventory(item: Dictionary): #grackle script
	var inventoryToSetTo = inventory["items"]
	
	var foundMatch = false
	for x in len(inventory["items"]):
		#do stuff
		if inventoryToSetTo[x]["name"] == item["name"]:
			if inventoryToSetTo[x]["quantity"] > item["quantity"] - 1:
				print("item " + item["name"] + " was empty")
			else:
				inventoryToSetTo[x]["quantity"] = inventoryToSetTo[x]["quantity"] + 1
				print("gave " + item["name"] + " to player")
			foundMatch = true
			

	#
	if not foundMatch:
		inventoryToSetTo.append(item)
		print("gave " + item["name"] + " to player")
	inventory["items"] = inventoryToSetTo
	generateInventory()
	pass

class PuzzlePieces:
	var mask
	var pieces
	func _init(index, p):
		pieces = int(p)
		mask = 1 << index
		if not pieces & mask:
			pieces = pieces | mask

func to_binary(intValue: int) -> String:
	var bin_str: String = ""
	while intValue > 0:
		bin_str = str(intValue & 1) + bin_str
		intValue = intValue >> 1
	return bin_str
	
func is_bit_active(index: int) -> bool:
	return (int(inventory["puzzlePieces"]) & (1 << index)) > 0

var inventory = getJsonAsDict("user://saveState.json")["inventory"]

func _ready() -> void:
	inventoryLabel.visible = false
	generateInventory()


func generateInventory():
	var screenstuff = ""
	
	for item in inventory["items"]:
		if item["spent"] == "false":
		#do stuff
			screenstuff = screenstuff + item["name"] + " x" + str(int(item["quantity"])) + "\n"
	if screenstuff == "":
		screenstuff = "you own NOTHING"
	#Render Puzzle Piece
	puzzlePiece1.color = colors[int(is_bit_active(0))]
	puzzlePiece2.color = colors[int(is_bit_active(1))]
	puzzlePiece3.color = colors[int(is_bit_active(2))]
	puzzlePiece4.color = colors[int(is_bit_active(3))]
	
	inventoryLabel.text = screenstuff


func _on_inventory_open() -> void:
	if inventoryLabel.visible: inventoryLabel.visible = false
	else: inventoryLabel.visible = true
	puzzlePiece1.color = colors[int(is_bit_active(0))]
	puzzlePiece2.color = colors[int(is_bit_active(1))]
	puzzlePiece3.color = colors[int(is_bit_active(2))]
	puzzlePiece4.color = colors[int(is_bit_active(3))]

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		# Call your function here
		autoSave()
		get_tree().quit()  # Proceed to quit the game
