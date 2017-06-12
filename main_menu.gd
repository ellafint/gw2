extends Control

#camera variables
var camera_start_pos = Vector2()
var trigger_right=false
var right_menu_endpoint=Vector2(2100.63916,239.408691)
var left_menu_endpoint=Vector2(400.994568,239.408691)
var camera_stepSize=50

#story counter
var story_counter=1

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
	get_node("right-menu/story-1").set_opacity(0)
	get_node("right-menu/story-2").set_opacity(0)
	get_node("right-menu/story-3").set_opacity(0)
	
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
	
	## Below code will disable camera main and make camera-story current camera
	get_node("camera-main").clear_current()
	get_node("camera-story").make_current()
	


func _on_main_right_pressed():
	get_node("camera_movement").play("main_pan_right")
	trigger_right=true
	pass

func _process(delta):
	if(trigger_right):
		#print("Pressed")
		trigger_right=false

func _on_right_left_pressed():
	get_node("camera_movement").play("right_pan_left")
	pass

func _on_continuestory_pressed():
	print(story_counter)
	if(story_counter==1):
		get_node("story_animation").play("story-1_appear")
		#not using below code; text is set in animation for timing purposes
		#get_node("right-menu/continue-story/continue-story-text").set_text("blahblahblah")
		story_counter+=1
	elif(story_counter==2):
		get_node("story_animation").play("story-2_appear")
		story_counter+=1
	elif(story_counter==3):
		get_node("story_animation").play("story-3_appear")
		story_counter+=1
	pass # replace with function body

func _on_main_left_pressed():
	get_node("camera_movement").play("main_pan_left")


func _on_left_right_pressed():
	get_node("camera_movement").play("left_pan_right")


func _on_storybutton_pressed():
	pass # replace with function body
