import UIKit

var str = "Hello, playground"

// 1.Classes don't have a memberwise default initializer

class Dog{
    var name: String
    var breed: String
    
    init(name: String, breed: String){
        self.name = name
        self.breed = breed
    }
    
    func makeNoise(){
        print("Woof!")
    }
}

var poppy = Dog(name: "Poppy", breed: "Poodle")

// w/o an init() class cannot be declared, classes in Swift dont have a default member wise initializer like the Struct
// say I initialize the values directly at first, lets see what happens

class Dog2{
    var name: String = "Poppy"
    var breed: String = "Poodle"
}

//the above code works, as the values are initialized, the end goal is to have values initialised whenever an instance is created ig

var poppy2 = Dog2()
print(poppy2.name)


//class Poddle: Dog {
//    init(name: String){
//        self.name = name
//        self.breed = "Poodle"
//    }
//}
//above is the wrong way, super.init() call is mandatory and the first thing to do, not really the first thing to do lol (neeche padho theek kiya during the quiz)

final class Poodle: Dog{
    init(name:String){
        super.init(name: name, breed: "Poodle")
        self.name = "Hello"
        self.breed = "No Poodle"
        
    }
    
    override func makeNoise() { //if no override marked, error -> Overriding declaration requires an 'override' keyword
        print("Yip!")
    }
}

var poodle1 = Poodle(name: "Hi")
print(poodle1.name)
poodle1.makeNoise()


//name is not "Hi", as after calling initiaizer in class, name is changed by us

//class PoodleBaby : Poodle {
//
//}
//error => nheritance from a final class 'Poodle'


class Poodle2: Dog2 {
    init(name: String){
        super.init()
    }
}

class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singer2 = singer
print(singer2.name)

singer.name="Diljit"

print(singer.name)
print(singer2.name)

singer2.name = "Diljit Dosanjh"

print(singer.name)
print(singer2.name)

struct Dancer{
    var name: String = "Disco Dancer"
}

var dancer = Dancer()

print(dancer.name)

var dancer2 = dancer
print(dancer2.name)

dancer2.name = "Diljit"

print(dancer.name)
print(dancer2.name)

class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("bye \(name) !")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

//output
//John Doe is alive!
//Hello, I'm John Doe
//bye John Doe !
//John Doe is alive!
//Hello, I'm John Doe
//bye John Doe !
//John Doe is alive!
//Hello, I'm John Doe
//bye John Doe !

//i.e. the class instance is destroyed whenever thw block of code that owns it i.e. the function or a loop or something ends!
//wait woah, its not that simple always, copys of classes existing and pointing to the same object make it a bit more complicated!
//All the copies point to the same underlying data, and so it’s now much harder to tell when the actual class instance is destroyed – when the final variable pointing to it has gone away.

//Behind the scenes Swift performs something called automatic reference counting, or ARC. ARC tracks how many copies of each class instance exists: every time you take a copy of a class instance Swift adds 1 to its reference count, and every time a copy is destroyed Swift subtracts 1 from its reference count. When the count reaches 0 it means no one refers to the class any more, and Swift will call its deinitializer and destroy the object.

//So, the simple reason for why structs don’t have deinitializers is because they don’t need them: each struct has its own copy of its data, so nothing special needs to happen when it is destroyed.

//You can put your deinitializer anywhere you want in your code, but I love this quote from Anne Cahalan: “Code should read like sentences, which makes me think my classes should read like chapters. So the deinitializer goes at the end, it's the ~fin~ of the class!”


//hence whenevr the iteration of the loop ends, the instance is destoyed and the deinit block is called, deinit is not a function though, as it doesnt have () infront of it!


class Singer3 {
    var name = "Taylor Swift"
}

let taylor = Singer3 ()
taylor.name = "Ed Sheeran"
print(taylor.name)

class Student {
    var name: String
    init(name: String){
        self.name = name
    }
}
class UniversityStudent: Student {
    var annualFees: Int
    init(name: String, annualFees: Int) {
        self.annualFees = annualFees
        super.init(name: name)
    }
}

// super.init() does not necessarily have to be the first statement in the subclass init() as stated above, sorry for the mistake future Japneet!
