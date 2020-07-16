import UIKit

var str = "Hello, playground"

func help()
{
    let message =
    """
    Hi!
    Sending Help....
    """
    print(message)
}


help()

func square(number: Int){
    print(number*number)
}

square(number: 3)
square(number: 8)

func square2(_ number: Int) -> (Int, String) // _ means no external name reqd, number is the internal name, to be used for the func definition//
{
    return (number*number, "Hi")
}

print(square2(3))


print(square2(8))

print(square2(3))

//Swift lets us provide 2 names for a parameter

func sayHello(to name: String){
    print("Hello, \(name) ")
}

sayHello(to: "Taylor")

//The first name is for use outside the function, the second is for use inside it
//parameter label is for outside, name is for inside

//print doesnt use a parameter label, we simple go print("this") instead of print(message: "Hi!")

func greet(_ person: String){
    print("Hello, \(person) ")
}

greet("japneet")

func greet(_ person: String, _ nicely: Bool = true){
    if nicely == true{
        print("Hello, \(person)")
    }
    else{
        print("Oh no, its \(person) again")
    }
}

greet("Japneet",false)

//variadic functions accept lots of inputs of the same time

print(1,2,3,4,5,6)

//swift converts these variadic inputs into an array

func square(_ numbers: Int...) {
    for number in numbers{
        print("Square of \(number) is \(number*number)")
    }
}

square(1,2,3,4,5,6,7,8)
square()

//every print has a newline at its termination

//like below

print("Hello")
print()
print()
print("Hello, we are 2 lines below now")

//Throwing functions return error if an error occurs
enum PasswordError: Error{
    case obvious
}
func checkPassword( _ password: String) throws -> Bool {
        if password == "password"
        {
            throw PasswordError.obvious
    }
    
    return true
}

//Swift doesn’t like errors to happen when your program runs, which means it won’t let you run an error-throwing function by accident.

//Error Catching is fun! do,try and catch

//DO starts a section of the code that may return an error
//TRY is used before every function that might thropw an error
//CATCH lets us handle errors carefully/gracefully

//if an error is encountered in the do block , execution immediately jumps to the catch block

do {
    try checkPassword("password134")
    print("Password seems fine")
}
catch{
    print("uh oh, find a better and more secure password mate")
}


//do try and catch yes!!!

//call by refernce concept coming below

func double(_ number: inout Int){
    number *= 2
}

//double(3) is wrong as a constant cannot be doubled at its place, so is double(&3)

var numberD = 3
double(&numberD)
print("\(double(&numberD))") //print prints a newline character by default

//1.Functions let us make our codes modular, increase reusabilioty, hence save us time
//2.Functions can accept parameters, just tell swift the type of parameter
//3.Functions can return paras too, just tell swift the type of the para to be returned
//4.U can use tuples to return several things
//5.Names and labels are nifty, use _ if you want to avoid a variable name outside
//6.for variadic function, just do Type... in definiton, Swift converts the numerous inputs into an ordered array, so you can easily loop over them, kaafi cool!
//VARIADIC INPUTS CAN EVEN HAVE NO VALUE eg print()
//7.functions can throw errors, define enum of errors first, of type Error, and use do try catch when executing a block of code that can throw errors
//8.Lastly, inout keyword allows us to use call by reference stuff, use & when passing a variable type, constants wont work here

func isPassingGrade(for scores: Int...) -> Bool {
    var total = 0
    for score in scores {
        total += score
    }
    if total >= 500 {
        return true
    } else {
        return false
    }
}

isPassingGrade(for: 560,30)

//if else testing should be exhaustive too, fn must always return the return type no matter the case
print() //--> print() prints a newline character by default

func numberOfTims(in array: [String]) -> Int {  //in can be used as an external name, 'in' is not a keyword as is, prolly one when coupled with for
    var count = 0
    for name in array {
        if name == "Tim" {
            count += 1
        }
    }
    return count
}

func formatLength(length length: Int) {  //same internal and external names give a warning, not an error
    print("That measures \(length)cm.")
}
formatLength(length: 95)


func defaultTry(this: Bool = true){
    if this{
        print("Default used")
    }
    else{
        print("Default not used")
    }
}

defaultTry()

let resignation = { (name: String) in
    print("Dear \(name), I'm outta here!")
}
func printDocument(contents: (String) -> Void) {
    print("Connecting to printer...")
    print("Sending document...")
    contents("Joanna")
}
printDocument(contents: resignation)

func holdClass(name: String, lesson: () -> Void) {
    print("Welcome to \(name)!")
    lesson()
    print("Make sure your homework is done by next week.")
}
holdClass(name : "Philosophy 101") {
    print("All we are is dust in the wind, dude.")  //When using trailing closure syntax, closure parameter name is skipped
}

func brewTea(steps: () -> Void) { //func brewTea(steps: () -> Void) { has the parameter steps defined as an Empty Tuple
    print("Get tea")
    print("Get milk")
    print("Get sugar")
    steps()
}
brewTea {
    print("Brew tea in teapot.")
    print("Add milk to cup")
    print("Pour tea into cup")
    print("Add sugar to taste.")
}

func repeatAction(count: Int, closure action: () -> Void) {
    for _ in 0..<count {
        action()
    }
}
repeatAction(count: 5) {
    print("Hello, world!")
}
let closure = {
    print("Hello World")
}
repeatAction(count:5, closure:closure)
