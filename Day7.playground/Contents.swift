import UIKit

func travel (action: (String) -> (Void)) {
    print("I'm ready to go!")
    action("London")
    print("I arrived!")
}

travel{(place : String) in
    print("I'm going to \(place) in my car!")
}



func login(then action: (String) -> ()) { //Writing () instead of Void in return type of closure also works
    print("Authenticating...")
    let username = "twostraws"
    action(username)
}
login { (username: String) in
    print("Welcome, \(username)!")
}

func playMusic(randomizer: () -> String) { //randomizer() is called before playMusic finishes, print executed from randomizer before return
    print("\(randomizer()) is playing.")
}
playMusic {
    print("Sorry, I only have one playlist!")
    return "Taylor Swift"
}

func playMusic2(randomizer2: () -> String) { //randomizer() is called before playMusic finishes, print executed from randomizer before return
    print("\(randomizer2()) is playing.")
}
playMusic2 {
    return "Taylor Swift"
    print("Sorry, I only have one playlist!")  //here print doesnt execute, as code after return statement is not executed
    //Look at the warning given
}

func makeRecorder(media: String) -> () -> String {
    switch media {
    case "podcast":
        return {
            return "I'm recording a podcast"
        }
    default:
        return {
            return "I'm recording a video"
        }
    }
}
let recorder = makeRecorder(media: "podcast")
print(recorder())

//func makeCodeGenerator(language: String) -> () -> Void {   //Wrong syntax, returns a string, not a closure
//    if language == "Swift" {
//        return "Swift rocks!"
//    } else {
//        return "Other languages are pretty great too!"
//    }
//}


func makeCodeGenerator(language: String) -> () -> String {  //func accepts a string, returns a (closure) that accepts nothing but returns a String
    if language == "Swift" {
        return
            {
                return "Swift rocks!"
            }
    } else {
        return
            {
                return "Other languages are pretty great too!"
            }
    }
}
let generator = makeCodeGenerator(language: "Swift")
print(generator())

func makeGame() -> (Int) -> Void {  //Int -> Void wont work for closures' data type, has to be Int in paranthesis
    // i.e. (Int) -> Void
    return {
        if $0 <= 5 {
            print("Let's play five-a-side football.")
        } else {
            print("Let's play regular football.")
        }
    }
}


func makeAdder() -> (Int) -> Void {  //Capturing values b y closure
    var sum = 0
    return {
        sum += $0
        print("Sum is now \(sum)")
    }
}
let adder = makeAdder()
adder(5)
adder(3)

func findTallest() -> (String, Double) -> (String) {
    var tallestName = ""
    var tallestHeight = 0.0 //If this was 0, below errors would have occured
    return {
        if $1 > tallestHeight {  //Cannot convert value of type 'Double' to expected argument type 'Int'
            tallestName = $0
            tallestHeight = $1  //Cannot assign value of type 'Double' to type 'Int'
        }
        return tallestName
    }
}
let tallest = findTallest()
var tallestName = tallest("Hannah", 1.72)
tallestName = tallest("Christina", 1.68)


func visitPlaces() -> (String) -> Void {
    var places = [String: Int]()
    return {
        places[$0, default: 0] += 1
        let timesVisited = places[$0, default: 0]
        print("Number of times I've visited \($0): \(timesVisited).")
    }
}
let visit = visitPlaces()
visit("London")
visit("New York")
visit("London")
visit("Delhi")
