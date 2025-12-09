extends CharacterBody2D

var speed = 50
var he_is_close = false
var picked_up = false
var behind_him = false
var holding_hands = false
var in_control = true
@onready var him : CharacterBody2D
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var camera = $Camera2D

func _physics_process(delta):
	him = get_tree().get_first_node_in_group("him")
	var direction = Input.get_axis("left","right")
	
	
	sprite_slip(direction)
	move(direction)
	hold_hand()
	animation()
	gravity()
	
	if picked_up:
		visible = false
		global_position = Vector2(0,0)
		
	else:
		visible = true
		if Input.is_action_just_pressed("pick_up"):
			pick_up()
	
	
		
	move_and_slide()
	
	
func gravity():
	if picked_up:
		return

	if is_on_floor():
		velocity.y = 0
		return
			
	velocity.y += 600
	
func move(dir):
	if not in_control:
		return
	velocity.x = speed * dir
func animation():
	
	if abs(velocity.x) > 0:
		animation_player.play("side walk her")
		
	else:
		animation_player.play("front_idle her")
		
	
			
func sprite_slip(dir):
	if not in_control:
		return
	if dir == 1:
		sprite_2d.flip_h = true
	elif dir == -1:
		sprite_2d.flip_h = false


func pick_up():
	
	if he_is_close:
		if not picked_up:
			#velocity.x = move_toward(velocity.x,him.global_position.x,speed)
			him.camera.enabled = true
			camera.enabled = false
			picked_up = true
			him.picked_up = true
			print("pick_up")
		else:
			picked_up = false
			him.picked_up = false
			
func hold_hand():
	pass
	if picked_up :
		return
		
	if not he_is_close:
		return
		
	if global_position.x > him.global_position.x:
		if Input.is_action_just_pressed("hold_hands"):
			him.holding_hands = true
			holding_hands = true
			him.camera.enabled = true
			camera.enabled = false
			in_control = false
			print("HOLDING HANDS")
			pass
	

func _on_area_2d_area_entered(area):
	
	var area_parent = area.get_parent()
	if area_parent.is_in_group("him"):
		area_parent.following_her = false
		he_is_close = true
	

func _on_area_2d_area_exited(area):
	var area_parent = area.get_parent()
	if area_parent.is_in_group("him"):
		he_is_close = false
		
		#
	
		
