# Link to the functions in order
# https://www.desmos.com/calculator/9lp2zqwsra
# Many abs() are unnessary, just safety proofing as to not get absurd values
class_name easingFunctions

func _init() -> void:
	pass

# X is ratio in, e is the exponent in y=1-(x-1)^(abs(e)*2)
static func easeOutQuart(x: float, e: int) -> float:
	# the set of all possible values for easeOut Functions is all even positive integers
	# {2,4,6,8,10,...}. to ensure this remains true we abs() and multiply by 2
	# This is different than easeInQuart
	return 1 - pow(x - 1, abs(e)*2);

# Inverse of easeOutQuart. Get ratio from y
static func easeOutQuartInverse(x: float, e: int) -> float:
	return 1 - pow(-x + 1, 1/(abs(e)*2.0));

# X is ratio in, e is the exponent in y=1-(x)^abs(e)
static func easeInQuart(x: float, e: int) -> float:
	return 1 - pow(x, abs(e))

# X is ratio in, e is exponent in y=1-2^(-abs(e)*x). Returns eased out 0-1
static func easeOutExpo(x: float, e: float) -> float:
	# Approaches 1 at infinity, so we round it
	if x == 1:
		return 1
	return 1 - pow(2, -abs(e) * x);
	
# X is ratio in, e is exponent in y=1-2^(abs(e)*(x-1)). Returns eased out 0-1
static func easeInExpo(x: float, e: float) -> float:
	# Approaches 1 at -infinity, so we round it
	if x == 1:
		return 0
	return 1 - pow(2, -e * x);
