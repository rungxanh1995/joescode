// Challenge 9: Classes

import Foundation

class Pets {
    var name:String = ""
    var age:Int = 0
    
    func feed() -> String {
        return "\(name) has been fed."
    }
    func clean() -> String {
        return "\(name) has taken a bath."
    }
    func play() -> String {
        return "\(name) enjoyed playing with you."
    }
    func sleep() -> String {
        return "\(name) went to sleep."
    }
}
var pet:Pets = Pets()
pet.name = "Mích"
print(pet.play())
print(pet.sleep())