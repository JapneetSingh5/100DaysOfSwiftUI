import UIKit

var str = "Hello, playground"

let dc = "Delhi Capitals"
let rr = "Rajasthan Royals"
let kkr = "Kolkata Knight Riders"
let csk = "Chennai Super Kings"
let ipl = [dc,kkr,csk,rr]
print(ipl[0])
//print(ipl[5]) -> gives a Fatal Error
//fatal errors lead to crashes
var x : [Int] = [3]
// when using type annotations, [Int] [String] [Double] [Bool]

//Sets have no order like arrays
//All items are uniques, no repetition


let colors = Set(["red","green","blue","blue"])
//print(colors[1]) -> no order ort index associated with any element of the set
//Sets are created fromm Arrays itself


//tuples are fixed - no addition no removal

var name = (first: "Japneet", last: "Singh")
print(name.1)
print(name.first)


//tuples are similar to json stuff etc etc , value types with connected data

//dictionaries are awesome lol

let lastNames:[String:String] = [
    "japneet" : "Singh",
    "gunneet" : "Sengh",
    "yo yo" : "Honey"]
lastNames["hello", default: "nhi hai"]
lastNames["dobby nonsens"]

let heights:[String:Double] = [
    "Ed Sheeran":1.78,
    "Taylor Swift":1.74
        ]
//print(heights["Me", default: "Unknown"])-->Check out this error
//default values are used to avoid getting back a nil from the query
//Arrays, sets, and dictionaries are called collections, because they collect values together in one place.

var array = [Int]()
var dictionary = [String:String]()
var set = Set<Int>()
var array2 = Array<Int>()
var dic2 = Dictionary<String,String>()
dic2["Name"]="Japneet"
dic2["Age"]="Eighteen"
print(dic2)
print(array)
array.append(3)
array.append(4)
print(array)

//Enumerations – usually called just enums – are a way of defining groups of related values in a way that makes them easier to use.



enum Result {
    case success
    case failure
}

let result = Result.success

print(result)

enum Activity {
    case running(destination: String)
    case singinf(song: String)
}

let varact = Activity.running(destination: "Delhi")
print(varact)

enum Planets: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planets(rawValue: 2)
print(earth ?? 1)

//Planets(rawValue: 5) = "jupiter" -> Error

//Arrays
//Sets
//Tuples
//Dictionaries
//Enums
