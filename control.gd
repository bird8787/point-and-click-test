extends Control
class PuzzlePieces:
	var memory: String
	var ftuikkhv: String
	func _init(m,f):
		memory = m
		ftuikkhv = f
class Item:
	var name: String
	var quantity: int
	func _init(n,q):
		name = n
		quantity = q
var invetnrgeiuh = {"items":[
	Item.new("pillow",8),
	Item.new("tv",2348765)],
	"puzzlepieces":[
	PuzzlePieces.new("somethinghappened","yes")]}	
func _ready():
	var screenstuff = ""
	for esxdrr7tfuf in invetnrgeiuh.items:
		#do stuff
		screenstuff = screenstuff + esxdrr7tfuf.name
	var inventory = invetnrgeiuh.items[0].name + "\n" + invetnrgeiuh.items[1].name
	$RichTextLabel.append_text(screenstuff)
