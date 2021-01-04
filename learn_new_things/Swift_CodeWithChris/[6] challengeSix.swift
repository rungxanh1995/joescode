// Challenge 6: Repeat-While loop

import Foundation

var cashOnHand:Double = 2000
var runningCash:Double
var percentGain:Double = 5.5
var yearsToInvest:Int = 8
var yearsElapsed:Int = 0

// Assign all cashOnHand to runningCash
runningCash = cashOnHand
// Convert percentGain to percent amount
percentGain = percentGain / 100
repeat {
	runningCash += (runningCash * percentGain)
	print("Accrued amount = Principal + Interest = \(runningCash)")
	yearsElapsed += 1
} while yearsElapsed < yearsToInvest