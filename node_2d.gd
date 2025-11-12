extends Node2D

const speed: int = 500

func _ready() -> void:
	
	# you may pass in a boolean value as a condition
	var canFly = false
	if canFly:
		print("its a bird")
	else:
		print("not a bird")
		
	print()
	
	# ==============================================================================================
		
	# imagine we have a door with a red and a blue lock, each lock can be opened by 2 keys
	# that means we need at least 1 key of each color
	var redKey1 = true
	var redKey2 = false
	var blueKey1 = false
	var blueKey2 = false
	# if you write this, we can enter with just redKey1
	# this which isnt doesnt make sense since the blue lock hasnt been opened
	if redKey1 or redKey2 and blueKey1 or blueKey2:
		print("you've unlocked the door")
	# with these parenthesis the code will run as intended
	if (redKey1 or redKey2) and (blueKey1 or blueKey2):
		print("you've unlocked the door")
	
	print("=======================================")
	
	# ==============================================================================================
	
	print("printing around of change to return:")
	# this excercize utilizes a while loop
	# objective: return the appropritate amount of change a customer needs
	# we will repeatedly return bills until theres no more change needed to be returned
	var change = 183
	while change > 0:
		if change >= 100:
			print("you give $100")
			change -= 100
		elif change >= 50:
			print("you give $50")
			change -= 50
		elif change >= 20:
			print("you give $20")
			change -= 20
		elif change >= 10:
			print("you give $10")
			change -= 10
		elif change >= 5:
			print("you give $5")
			change -= 5
		else:
			print("you give $1")
			change -= 1
	
	print("=======================================")
		
	# ==============================================================================================

	# variable index is declared outside the scope of WHILE
	var index = 1
	while index < 10:
		print(index)
		index += 1
	print(index)
	# therefore we can access it after the while loop because its never erased
	
	# variable temp is declared within the scope of the IF statment
	if true:
		var temp = 1
		print(temp)
	#print(temp)
	# ^^^^ if you uncomment this line, therell be an error
	# thats because temp was erased when the code exited the IF's scope
	
	print("=======================================")
	
	# ==============================================================================================
	
func _process(delta: float) -> void:
	
	# this method call detects if we've detected any inputs for the 2 buttons
	var direction = Input.get_axis("Left", "Right")
	# depending on the 2 buttons pressed, this will move the character only on the x axis
	position.x += direction * speed * delta
	
	# the code below will allow you to move on x and y axis
	# but we wont be using this because the game we're making doesn't need it	
	
	#var direction = Input.get_vector("Left", "Right", "Up", "Down")
	#position += direction * speed * delta
