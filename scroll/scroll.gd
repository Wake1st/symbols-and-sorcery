extends StaticBody3D

signal selected

var mouse_over:bool = false


func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false


func _physics_process(_delta):
	if mouse_over && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		selected.emit()
