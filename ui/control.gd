extends Control


func _on_left_pressed():
	$CanvasLayer/left.modulate.a = 0.5


func _on_left_released():
	$CanvasLayer/left.modulate.a = 1.0


func _on_right_pressed():
	$CanvasLayer/right.modulate.a = 0.5


func _on_right_released():
	$CanvasLayer/right.modulate.a = 1.0


func _on_call_pressed():
	$CanvasLayer/call.modulate.a = 0.5


func _on_call_released():
	$CanvasLayer/call.modulate.a = 1.0

func _on_pick_up_pressed():
	$CanvasLayer/pick_up.modulate.a = 0.5


func _on_pick_up_released():
	$CanvasLayer/pick_up.modulate.a = 1.0


func _on_enter_pressed():
	$CanvasLayer/enter.modulate.a = 0.5


func _on_enter_released():
	$CanvasLayer/enter.modulate.a = 1.0
