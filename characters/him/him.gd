extends CharacterBody2D


var speeed = 60
var holding_hands := false
var picked_up := false
var following_her = true
var behind_her = false
var in_control = false
var speak = false
var on_textui = false
var textbox_open = false
var speak_count = 0
var her_position

var follow_speed := 100.0    # desired horizontal speed when following
var accel := 500.0           # how fast velocity moves to desired
var stop_distance := 8.0     # how close before we stop following

@onready var her : CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var camera = $Camera2D
@onready var text_ui = $text_ui
@onready var label = $RichTextLabel
@onready var text_timer = $text_Timer
@onready var text_animation = $text_animation

func _physics_process(delta):
	her = get_tree().get_first_node_in_group("Queen")
	var direction = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("follow"):
			
		if not her.he_is_close:
			following_her = true
			
		else:
			following_her = false
			#speak = true
			
	if her.he_is_close:
		#print('close')
		if speak_count != 69 and speak_count == 0:
			speak = true
		
	if picked_up:
		in_control = true
		
	else:
		in_control = false
		

	#print(velocity.x)
	
	move(direction)
	sprite_slip(direction)
	follow_her(delta)
	speak_func()
	drop_her()
	animation()
	gravity()
	move_and_slide()
	pass
	
func gravity():
	if is_on_floor():
		velocity.y = 0
		return
		
	
	velocity.y += 600
		
func sprite_slip(dir):
	if not in_control:
		if velocity.x > 0:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false
			
	else:
		if dir == 1:
			sprite_2d.flip_h = true
		elif dir == -1:
			sprite_2d.flip_h = false
			
func speak_func():
	if not speak:
		text_ui.visible = false
		label.visible = false
		
		return
	#print(speak_count)
	if speak_count == 0 :
		#await get_tree().create_timer(0.5).timeout
		text_ui.visible = true
		text_animation.play("openning")
		
		label.text = "heyyy cutieee , I LOVE YOUUUUU :)"
		if textbox_open:
			text_animation.play("default")
			label.visible = true
			
			text_timer.stop()
			text_timer.is_stopped()
			text_timer.start()
			speak_count += 1
		
		
	#print(text_timer.wait_time)
	if speak_count == 2:
		text_ui.visible = true
		text_animation.play("openning")
		#await get_tree().create_timer(0.6).timeout
		label.text = "The Moon is lovely isn't it ? "
		
		if textbox_open:
			text_animation.play("default")
			label.visible = true
			
			text_timer.stop()
			text_timer.is_stopped()
			text_timer.start()
			speak_count += 1
		#pass
		#
	if speak_count == 4:
		text_ui.visible = true
		text_animation.play("openning")
		#await get_tree().create_timer(0.6).timeout
		label.text = "hey let's go inside the house, i have something to show you. Want me to pick you up and walk there ? :) "
		
		if textbox_open:
			text_animation.play("default")
			label.visible = true
			
			text_timer.stop()
			text_timer.is_stopped()
			text_timer.start()
			speak_count += 1
			
	if speak_count == 69:
		text_ui.visible = true
		text_animation.play("openning")
		#await get_tree().create_timer(0.6).timeout
		label.text = "oh it looks like the lights are off, sorry about that. don't get scared ok ? let me just turn the lights back on"
		if textbox_open:
			text_animation.play("default")
			label.visible = true
			
			text_timer.stop()
			text_timer.is_stopped()
			text_timer.start()
			speak_count += 1
		
		
	if speak_count == 71:
		text_ui.visible = true
		text_animation.play("openning")
		#await get_tree().create_timer(0.6).timeout
		label.text = "HAPPPY BIRTHDAY HONEY, I AM SORRY THIS IS ALL I CAN AFFORD AND DO IN 2 DAYS, I HOPE YOU THAT YOU GROW UP TO THE PERSON WHICH YOU WANT TO BE AND WELL IDK IF I WILL BE THERE IN YOUR FUTRE, I WANNA THANK YOU FOR BEING IN MY LIFE AND MAKING it WONDERFULL"
		if textbox_open:
			text_animation.play("default")
			label.visible = true
			text_timer.wait_time = 20
			text_timer.stop()
			text_timer.is_stopped()
			text_timer.start()
			speak_count += 1
			
	if speak_count == 73:
		text_ui.visible = true
		text_animation.play("openning")
		#await get_tree().create_timer(0.6).timeout
		label.text = "I know i am weird and all , i made a game for you as a present, yea a bitch move. but i just wantt to thankyou for being a great persson and an angel. i know that i can never find another girl like you ever. you are the only person that feels like home, that i can talk to."
		if textbox_open:
			text_animation.play("default")
			label.visible = true
			text_timer.wait_time = 20
			text_timer.stop()
			text_timer.is_stopped()
			text_timer.start()
			speak_count += 1

func text_box_opened():
	textbox_open = true
func move(dir):
	if in_control:
		velocity.x = 300 * dir
	
func animation():
	if not picked_up:
		if abs(velocity.x) > 0:
			animation_player.play("side running me")
			
		else:
			animation_player.play("front idle me")
		
	else:
		if abs(velocity.x) > 0:
			animation_player.play("running holding her")
			
		else:
			animation_player.play("holding her idle")
			
		
func drop_her():
	if not her.picked_up:
		return
		
	
	if her.he_is_close:
		return
		
	if Input.is_action_just_pressed("pick_up"):
		her.picked_up = false
		picked_up = false
		her.camera.enabled = true
		camera.enabled = false
		
		if sprite_2d.flip_h:
			her.global_position = Vector2(global_position.x + 20, global_position.y)
			
			
		else:
			her.global_position = Vector2(global_position.x - 20, global_position.y)


func follow_her(delta):
	if her == null:
		return
	
	if in_control:
		return
		
	if not following_her:
		velocity.x = move_toward(velocity.x, 0, accel )
		return

	var dist := her.global_position.x - global_position.x

	if abs(dist) <= stop_distance:
		following_her = false
		velocity.x = move_toward(velocity.x, 0, accel * delta)
		return

	var desired: float = sign(dist) * follow_speed

	velocity.x = move_toward(velocity.x, desired, accel * delta)
		
	


func _on_text_timer_timeout():
	speak = false
	textbox_open = false
	if speak_count == 72:
		speak_count+=1
		speak = true
		
	if speak_count == 1:
		speak_count += 1
		speak = true
		
	if speak_count == 3:
		await get_tree().create_timer(0.8).timeout
		speak_count += 1
		speak = true
