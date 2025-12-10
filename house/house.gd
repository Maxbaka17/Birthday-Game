extends Node2D


var birthday = false
var wish = false

@onready var her = $Her
@onready var him = $Him

@onready var animation_player = $AnimationPlayer
@onready var color_rect = $ColorRect
@onready var node_2d = $Node2D

@onready var confetty = $confetty
@onready var birthday_song = $birthday_song
@onready var wishing = $wishing


func _ready():
	her.camera.offset.y = -200
	him.camera.offset.y = -200
	him.speak_count = 69
	him.speak = true
	node_2d.get_node("AnimationPlayer").play("default")
	animation_player.play("default")
	$AnimatedSprite2D.play("default")
	$Timer.start()
#	color_rect.visible = true
	
func _physics_process(delta):
	her.camera.offset.y = -200
	him.camera.offset.y = -200
	

		
	if color_rect.visible == false:
		if wish:
			wishing.play()
			confetty.play()
			$Timer2.start()
			wish = false
			
		else:
			if birthday:
				birthday_song.play()
				him.speak_count = 71
				him.speak = true
				birthday = false
		


func _on_timer_timeout():
	color_rect.visible = false
	#birthday = true
	wish = true

func _on_timer_2_timeout():
	birthday = true
