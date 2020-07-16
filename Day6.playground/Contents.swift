import UIKit

var str = "Hello, playground"

let driving = {
    print("I am driving ")
}

driving()

let driving2 = {
    (place : String) -> String in
    return "Lets go to \(place)"
}

driving2("London")

func travel(_ action: () -> Void) {
    print("Im getting ready to go")
    action()
    print("Im arrived")
}

travel(driving)
print()

travel() {
    print("Im driving in a car")
}

travel{
    print("yeehaw")
}

//var cutGrass = { (length currentLength: Double) in
//    switch currentLength {
//    case 0...1:
//        print("That's too short")
//    case 1...3:
//        print("It's already the right length")
//    default:
//        print("That's perfect.")
//    }
//}

//Closures cannot have external parameter labels!

//SWITCH HAS TO BE EXHAUSTIVE\!!!!!!
//WE DONT USE PARAMETER NAMES WHEN CALLING A CLOSURE

var buyMagazine = { (name: String) -> Int in
    let amount = 10
    print("\(name) costs \(amount)")
    return amount
}
//buyMagazine(name: "Wired")

let resignation = { (name: String) in
    print("Dear \(name), I'm outta here!")
}
func printDocument(contents: () -> Void) {
    print("Connecting to printer...")
    print("Sending document...")
    contents()
}


//printDocument(contents: resignation)
//Oops – that's not correct. printDocument() says its parameter must be a closure that accepts no parameters, but the closure it is given takes a string.


func goOnVacation(to destination: String, _ activities: () -> Void) {
    print("Packing bags...")
    print("Getting on plane to \(destination)...")
    activities()
    print("Time to go home!")
}
goOnVacation(to: "Mexico") {
    print("Go sightseeing")
    print("Relax in sun")
    print("Go hiking")
}
