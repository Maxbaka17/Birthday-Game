extends CharacterBody2D


var speeed = 60
var holding_hands := false
var picked_up := false
var following_her = true
var behind_her = false
var in_control = false
var her_position

var follow_speed := 100.0    # desired horizontal speed when following
var accel := 500.0           # how fast velocity moves to desired
var stop_distance := 8.0     # how close before we stop following

@onready var her : CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var camera = $Camera2D

func _physics_process(delta):
	her = get_tree().get_first_node_in_group("Queen")
	var direction = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("follow"):
			
		if not her.he_is_close:
			following_her = true
			
		else:
			following_her = false
		
		

		
		
	if picked_up:
		in_control = true
		
	else:
		in_control = false
		
	

	#print(velocity.x)
	
	move(direction)
	sprite_slip(direction)
	follow_her(delta)
	drop_her()
	animation()
	gravity()
	move_and_slide()
	pass
	
func gravity():
	if not is_on_floor():
		velocity.y += 600
	
	else:
		velocity.y = 0
		
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
	if her.picked_up:
		if her.global_position == Vector2(0,0):
			if not her.he_is_close:
				if Input.is_action_just_pressed("pick_up"):
					her.picked_up = false
					picked_up = false
					her.camera.enabled = true
					camera.enabled = false
					if sprite_2d.flip_h:
						her.global_position.x = global_position.x + 20
						
					else:
						her.global_position.x = global_position.x - 20


func follow_her(delta):
	if her == null:
		return
	
	if in_control:
		return
		
	if not following_her:
		# smoothly slow to stop when not following
		velocity.x = move_toward(velocity.x, 0, accel )
		return

	# distance from me to her (positive => her is to my right)
	var dist := her.global_position.x - global_position.x

	# if we're close enough, stop following
	if abs(dist) <= stop_distance:
		following_her = false
		velocity.x = move_toward(velocity.x, 0, accel * delta)
		return

	# desired velocity: go toward her at follow_speed
	var desired: float = sign(dist) * follow_speed

	# accelerate toward desired velocity
	velocity.x = move_toward(velocity.x, desired, accel * delta)
		
	
