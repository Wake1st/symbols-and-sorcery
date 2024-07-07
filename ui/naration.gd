class_name Descriptions
extends Control

@onready var textBox = %TextBox

var descriptions:Dictionary


func _ready():
	var file = "./descriptions.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		descriptions = json_as_dict 
		print(json_as_dict)


func add_text(t:String) -> void:
	textBox.text += "\n%s" % t
