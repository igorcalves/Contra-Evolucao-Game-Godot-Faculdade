extends NinePatchRect

@onready var text: RichTextLabel = get_node("RichTextLabel")

var msg_queue: Array = [
	"oi, tudo bem :",
	"manoel gomes"
]

# Calledwhen the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(event):
	if event is InputEventKey and event.is_action_pressed("ui_accept"):
		show_messege()
		


func show_messege() -> void:
	var _msg: String = "msg_queue.pop_at(1)"
	text.bbcode_text =_msg
	print(msg_queue)
