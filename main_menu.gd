extends Control

#camera variables
var camera_start_pos = Vector2()
var right_menu_endpoint=Vector2(2100.63916,239.408691)
var left_menu_endpoint=Vector2(400.994568,239.408691)
var camera_stepSize=50

#story counter
var story_counter=1

#global timer variables
var timer = null
var timeout_done = false

func _ready():
	# Get game_state best_score and associated best_time from file
	var best_score = get_node("/root/game_state").best_score
	var elapsed = get_node("/root/game_state").best_time
	
	#cast elapsed to integer because it became a float when adding milliseconds feature
	var minutes = int(elapsed) / 60
	var seconds = int(elapsed) % 60
	#calculate milliseconds and multiply by 1000 for display
	var milliseconds = elapsed - int(elapsed)
	var milliseconds_display = milliseconds * 10
	var str_elapsed = "%01dm %02d.%01ds" % [minutes, seconds, milliseconds_display]
	
	#hardcode camera to start here
	camera_start_pos = get_node("camera-main").set_pos(Vector2(1200,239.408691))
	print(camera_start_pos)
	
	# Initially set all story texts to invisible:
	get_node("left-screen/story-1").set_opacity(0)
	get_node("left-screen/story-2").set_opacity(0)
	get_node("left-screen/story-3").set_opacity(0)
	get_node("left-screen/story-4").set_opacity(0)
	
	# hardcode if elapsed time==9999 (default starting), then don't display anything; else display best time
	if(elapsed == 9999):
		get_node("time").set_text("Time: ")
	else:
		get_node("time").set_text("Time: " + str_elapsed)
	
	# hardcode if best_score==0 (default starting), then don't display anything; else display best time
	if(best_score == 0):
		get_node("score").set_text("Best Score: ")
	else:
		get_node("score").set_text("Best Score: " + str(best_score))

	set_process(true)

func _on_play_pressed():
	#get_node("/root/game_state").points = 0
	get_node("/root/game_state").setup_game()
	get_tree().change_scene("res://FoxRun.tscn")

func _on_rules_pressed():
	#get_tree().change_scene("res://instructions.tscn")
	## Below code will disable camera main and make camera-story current camera -- OLD code
	#get_node("camera-main").clear_current()
	#get_node("camera-story").make_current()
	pass
	

func _on_main_right_pressed():
	get_node("camera_movement").play("main_pan_right")
	pass

func _process(delta):
	""" Below code to check timeout_done timer functionality
	if(timeout_done):
		print("HELLO")
		timeout_done=false
	"""
	pass

func _on_right_left_pressed():
	get_node("camera_movement").play("right_pan_left")
	pass

func _on_continuestory_pressed():
	print(story_counter)
	if(story_counter==1):
		get_node("story_animation").play("story-1_appear")
		##### timeout to change continue story button text #####
		var t = Timer.new()
		t.set_wait_time(1.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		#### change continue-story-text ###
		get_node("left-screen/continue-story/continue-story-text").set_text("What?!! Oh no!!")
		story_counter+=1
	elif(story_counter==2):
		get_node("story_animation").play("story-2_appear")
		##### timeout to change continue story button text #####
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		#### change continue-story-text ###
		get_node("left-screen/continue-story/continue-story-text").set_text("Yeah! KILL EM ALL!")
		story_counter+=1
	elif(story_counter==3):
		get_node("story_animation").play("story-3_appear")
		##### timeout to change continue story button text #####
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		#### change continue-story-text ###
		get_node("left-screen/continue-story/continue-story-text").set_text("HECK YEAH!")
		story_counter+=1
		
	elif(story_counter==4):
		get_node("story_animation").play("story-4_appear")
		##### timeout to change continue story button text #####
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		#### change continue-story-text ###
		get_node("left-screen/continue-story/continue-story-text").set_text("FOR THE CHAI!!!")
		story_counter+=1
	pass

func _on_main_left_pressed():
	get_node("camera_movement").play("main_pan_left")
	# global timer testing
	#set_timer(5)

##### One way of implementing global timer, uses timeout_done as boolean check; is checked in _process function #### 
func set_timer(var timer_delay):
	timer = Timer.new()
	timer.set_wait_time(timer_delay)
	timer.connect("timeout",self,"on_timeout_complete")
	add_child(timer)
	timer.start()
	print(timeout_done)

func on_timeout_complete():
	print(timeout_done)
	timeout_done=true;

##### global timer ######

func _on_left_right_pressed():
	get_node("camera_movement").play("left_pan_right")
	#reset story
	story_counter=1
	print(story_counter)
	get_node("left-screen/story-1").set_opacity(0)
	get_node("left-screen/story-2").set_opacity(0)
	get_node("left-screen/story-3").set_opacity(0)
	get_node("left-screen/story-4").set_opacity(0)
	get_node("left-screen/continue-story/continue-story-text").set_text("Tell me a story!")


func _on_storybutton_pressed():
	pass # replace with function body
	

