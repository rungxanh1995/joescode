// Challenge 5: Loops

import Foundation

var drawPixel:String = "*"
var height:Int = 6
var tempRow:String = ""

for columnPixel in 1...height {
    tempRow = ""
    for _ in 1...columnPixel {
        tempRow += drawPixel
    }
    print(tempRow)
}