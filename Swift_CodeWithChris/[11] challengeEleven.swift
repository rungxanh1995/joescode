// Challenge 11: Subclasses

import Foundation

class Pets {
    var name:String = ""
    var age:Int = 0
    
    init() {
        name = "Doggo"
    }
    init(_ name:String) {
        self.name = name
    }
    func feed() {
        print("\(name) has been fed.")
    }
    func clean() {
        print("\(name) has taken a bath.")
    }
    func play() {
        print("\(name) enjoyed playing with you.")
    }
    func sleep() {
        print("\(name) went to sleep.")
    }
}

class Tamagotchi:Pets {
    var hunger:Int = 0
    var dirt:Int = 0
    var boredom:Int = 0
    var drowsiness:Int = 0
    
    override init() {
        super.init()
        boredom = 60
    }
    override init(_ name:String) {
        super.init(name)
        boredom = 60
    }
    override func feed() {
        if hunger == 0 {
            print("\(name) is already full.")
        } else {
            super.feed()
            hunger = 0
            boredom += 20
            dirt += 20
            drowsiness += 10
        }
    }
    override func clean() {
        if dirt == 0 {
            print("\(name) is already clean.")
        } else {
            super.clean()
            dirt = 0
            hunger += 20
            boredom += 20
            drowsiness += 10
        }
    }
    override func play() {
        if boredom == 0 {
            print("\(name) is already done playing.")
        } else {
            super.play()
            boredom = 0
            hunger += 20
            dirt += 20
            drowsiness += 10
        }
    }
    override func sleep() {
        if drowsiness == 0 {
            print("\(name) has already slept.")
        } else {
            super.sleep()
            drowsiness = 0
            boredom += 20
            hunger += 20
            dirt += 10
        }
    }
    func check() {
        print("Hunger \(hunger) : Dirt \(dirt) : Boredom \(boredom) : Drowsiness \(drowsiness)")
        if hunger >= 60 {
            print("\(name) is hungry.")
        }
        if dirt >= 60 {
            print("\(name) is dirty.")
        }
        if boredom >= 60 {
            print("\(name) is bored.")
        }
        if drowsiness >= 60 {
            print("\(name) is sleepy.")
        }
    }
}
var pet = Tamagotchi()
print(pet.name)
pet.name = "Mích"
print(pet.name)

pet.play()
pet.check()
pet.feed()
pet.play()
pet.feed()
pet.check()
pet.feed()
pet.check()
pet.clean()
pet.check()
pet.play()
pet.check()
