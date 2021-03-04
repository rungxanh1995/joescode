// Challenge 8: Simple functions w/ params

import Foundation

func walk(arg1 direction:String, arg2 step:Int) -> String {
    return "You have walked \(String(step)) steps to the \(direction)"
}
var resultStr = walk(arg1: "North", arg2: 10)
print(resultStr)
