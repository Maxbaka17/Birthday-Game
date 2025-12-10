extends Node2D

var enter_house_button 
var in_range = false

func _physics_process(delta):
	enter_house_button = get_tree().get_first_node_in_group("enter")
	
	if in_range:
		enter_house_button.visible = true
		
	else:
		enter_house_button.visible = false
		
		
	if Input.is_action_just_pressed("enter"):
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file("res://house/house.tscn")
		
func _on_area_2d_area_entered(area):
	var area_parent = area.get_parent()
	if area_parent.is_in_group("him") and area_parent.picked_up == true or area_parent.is_in_group("Queen"):
		in_range = true
		#get_tree().change_scene_to_file("res://house/house.tscn")
	
		#he_is_close = false


func _on_area_2d_area_exited(area):
	var area_parent = area.get_parent()
	if area_parent.is_in_group("him") and area_parent.picked_up == true or area_parent.is_in_group("Queen"):
		in_range = false
		#get_tree().change_scene_to_file("res://house/house.tscn")
	
		#he_is_close = false
