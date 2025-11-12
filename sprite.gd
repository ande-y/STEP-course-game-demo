extends Node2D

# please remember that indentation is very important
# also remember that lower / upper case letters matter

func _ready() -> void:
	
	# this is a comment, the computer wont run this
	
	var myInteger: int = 5.1
	var myFloat: float = 3.14
	var myString: String = "Hello"
	var myBoolean: bool = false
	# remember to use str() if youre printing multiple variables of non String type
	print(str(myInteger) + "Hello" + str(myFloat) + str(myBoolean))
	
	# you can change the sprite's position in both ways, through Vector2 is easier to write
	#position.x = 500
	#position.y = 300
	position = Vector2(500, 300)
	# rather than appear in the top left (0 , 0 origin cooridinates), the sprite will appear
	# roughly around the middle of the your debug window when you run the program
	
	# the sprite will start off being tilted by 45 degrees when you run this program
	rotation = 45
	
	var a = 500
	# the if statement check if a condition and runs its code if true
	if 5 * 100 == a:
		print("this is true!")
	# you may have as many elif statements as you like
	# they come after the if statement and do the exact same as an if statement
	elif 500 < a and 510 > a:
		print("a is a little more than 500")
		print("a is " + str(a - 500) + "less than 500")
	elif 490 < a and 500 > a:
		print("a is a little less than 500")
		print("a is " + str(500 - a) + "more than 500")
	# this else statement is not necessary
	# it is used to do something if all the other conditions are not met
	else:
		print("this is not true")
	
	
func _process(delta: float) -> void:
	
	# both lines of code do the exact same thing
	#rotation = rotation + (0.01 * delta)
	rotation += 1 * delta
	# this line of code will spin the sprite slowly in the debug window when you run this program
	
