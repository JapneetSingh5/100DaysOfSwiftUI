import UIKit

var str = "Hello, playground"
str = "Hello Hello boys wasuuuppp "
print(str)

//Swift is a type safe language ie every variable must be of a specific type

var age = 38
str = "String cannot be assigned an integer value d'uh "
// Instead of commas, swift allows us to use underscores as thousand seperatorsololol
age = 8_000_000_000

var multiline = """
Hello \
Hi \
Kaise Ho?
"""
var multiline2 = """
Hello
Hi
Kaise Ho?
"""
var booleanvar = true
age = 8_000_000

//Swift is very particular about how you write those quote marks: the opening and closing triple must be on their own line, but opening and closing line breaks won’t be included in your final string.

//If you only want multi-line strings to format your code neatly, and you don’t want those line breaks to actually be in your string, end each line with a \, like this:
//The final three quotes must be on a line by themselves.
//
//var str2 = """
//This goes \
//over multiple \
//lines
//"""

var double1 = 3.123123213
type(of: double1)
var doubleFloat : Float = 2.33
type(of: doubleFloat)
//Lets learn String Interpolation

str = "\(double1)"

print(str)

print("value is \(double1*23/23)")

print("value is \(str) ")


let kohli="virat"
//kohli="virat2"
//changing or trying to change the value of a let defined constant will make xcode throw an error - constants stay constant as implied by the name

//Swift is kaafi intelligent, it infers types of variables on its own, process being called TYPE INFERENCE
//sometimes though you may need to explicitly define or annotate the type of a var and not rely on seift's inference - this is how you do it

var str2 = "Swift infers this type as a string"
print(str2)

var str3 : Int = 3
let var2:Double = 1
//let var3:Int = 3.0 //Int cannot contain 3.09 but Double can contain 1, which swift understands then as 1.0
