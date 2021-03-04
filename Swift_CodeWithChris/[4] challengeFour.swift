// Challenge 4: Switch case statements

import Foundation

var strOperator:String = "/"
var num1:Float = 5
var num2:Float = 6
var result:Float = 0

switch strOperator {
case "+":
    result = num1 + num2
    print(result)
case "-":
    result = num1 - num2
    print(result)
case "*", "x":
    result = num1 * num2
    print(result)
case "/":
    result = num1 / num2
    print(result)
default:
    print("This operator doesn’t exist.")
}