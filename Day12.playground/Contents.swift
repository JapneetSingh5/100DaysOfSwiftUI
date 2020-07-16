import UIKit

var str: String? = "Hello, playground"


//guard let unwrapping
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}


greet(str)

str=nil

greet(str)

//if let unwrapping

if let unwrapped = str {
    print("Hello \(unwrapped)")
}
else{
    print("na diya")
}

let str2 = "5"
let num = Int(str2)

print(type(of: num))

let num2 = Int(str2)!

print(type(of: num2))

let str3 = "five"
//let num3 = Int(str3)!
//error above : error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
//The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.

let age2: Int! = nil

print(age2 ?? 2)

//does not crash on inplicitly unwrapping though, should have, maybe an app will crash on such an error

//Implicitly unwrapped optionals exist because sometimes a variable will start life as nil, but will always have a value before you need to use it. Because you know they will have a value by the time you need them, it’s helpful not having to write if let all the time.


func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous"

let names = ["John", "Paul", "George", "Ringo"]

var beatle = names.first?.uppercased()
//above beatle will be an optional
print(beatle)

beatle = names.first?.uppercased() ?? "Anonymous"

print(beatle ?? "Anonymous")  //here on nilcoalescing, printed is no more an optional but a proper string

struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

let person=Person(id:"abcdefghijkl")

print(person?.id) //the person instance of struct Person is an optional here

let person2 = Person(id:"123456789")
print(person2?.id)

//here also person 2 is an optional, it has to be unwrapped
//have a look at the fixes to find the various ways we can unwrap
//Basically if the init?() is optional, then the struct instance declared will be an optional and hence, the struct instance will have to be unwrapped!

class Person2 {
    var name = "Anonymous"
}

class Customer2: Person2 {
    var id = 12345
}

class Employee2: Person2 {
    var salary = 50_000
}

let customer = Customer2()
let employee = Employee2()
let people = [customer, employee]
print(type(of: people))
//type of people is inferred as an array of People2 as both Employee2 and Customer2 inherit from it

for person in people {
    if let customer = person as? Customer2 {
        print("I'm a customer, with id \(customer.id)")
    } else if let employee = person as? Employee2 {
        print("I'm an employee, earning $\(employee.salary)")
    }
}

var weatherForecast: String? = "sunny"
if let forecast = weatherForecast {
    print("The forecast is \(forecast).")
} else {
    print("No forecast available.")
}

//trying to unwrap a non-optional, regular data type will result in an error

var bestScore: Int? = nil
bestScore = 101
if bestScore != nil {
    print("You got a high score!")
} else {
    print("Better luck next time.")
}

class Player {
    var name: String = "Anonymous"
    var salary: Int?
}
let player = Player()
let salary = player.salary

//Interesting, if a property is set to optional in a struct and it isn't iniitialized, it wont be a problem, so cool and so logical nicee

let flavor = "apple and mango"
if let taste = flavor as? String {
    print("We added \(taste).")
}

class Reading {
    var value = 0.0
}
class TemperatureReading: Reading { }
let temperature = TemperatureReading()
if let reading = temperature as? Reading {
    print("The reading is \(reading.value).")
}
