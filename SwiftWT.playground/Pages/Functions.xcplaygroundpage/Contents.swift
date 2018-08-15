//
// Functions.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 函数
/*:
 `Swift` 统一的函数语法非常的灵活，可以用来表示任何函数，包括从最简单的没有参数名字的 `C` 风格函数，到复杂的带局部和外部参数名的 `Objective-C` 风格函数。参数可以提供默认值，以简化函数调用。参数也传地址引用。
 
 在 `Swift` 中，每个函数都有一个由函数的参数值类型和返回值类型组成的类型。我们可以把函数类型当做任何其他普通变量类型一样处理，这样就可以更简单地把函数当做别的函数的参数，也可以从其他函数中返回函数。函数的定义可以写在其他函数定义中，这样可以在嵌套函数范围内实现功能封装。
 
 在 `Swift` 中，函数是一等公民。
 */

//: ## 函数的定义与调用
/*:
 定义一个函数，通过声明参数列表和函数的返回类型即可，语法：`func` `functionName(param1:` `Type`, `param2:` `Type)` `->` `ReturnType`；
 
 调用函数时通过点语法调用，传入指定类型的参数即可实现调用：
 
     func greet(person: String) -> String {
         let greeting = "Hello, " + person + "!"
         return greeting
     }
 
     print(greet(person: "Anna"))
     // 打印 "Hello, Anna!"
     print(greet(person: "Brian"))
     // 打印 "Hello, Brian!"
 
 函数定义的各种形式：
 - 无参函数：`func` `functionName()` `->` `ReturnType`
 - 无返回值函数：`func` `functionName(param1:` `Type`, `param2:` `Type)`
 */

//: ## 参数标签和参数名称
/*:
 每个函数参数都有一个参数标签（argument label）以及一个参数名称（parameter name）。参数标签在调用函数的时候使用；调用的时候需要将函数的参数标签写在对应的参数前面。参数名称在函数的实现中使用。默认情况下，函数参数使用参数名称来作为它们的参数标签：
 
     func someFunction(firstParameterName: Int, secondParameterName: Int) {
     // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
     }
     someFunction(firstParameterName: 1, secondParameterName: 2)
 
 ### 指定参数标签
 可以在参数名称前指定它的参数标签，中间以空格分隔：
 
     func someFunction(argumentLabel parameterName: Int) {
         // 在函数体内，parameterName 代表参数值
     }
 
 ### 忽略参数标签
 如果你不希望为某个参数添加一个标签，可以使用一个下划线（_）来代替一个明确的参数标签：
 
     func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
         // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
     }
     someFunction(1, secondParameterName: 2)
 
 */

//: ## 默认参数值
/*:
 可以在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）。当默认值被定义后，调用这个函数时可以忽略这个参数：
 
     func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
         // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
     }
     someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
     someFunction(parameterWithoutDefault: 4) // parameterWithDefault = 12
 
 */
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6)
someFunction(parameterWithoutDefault: 4)
//: ## 可变参数
/*:
 一个可变参数（variadic parameter）可以接受零个或多个值。函数调用时，可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数。
 
 可变参数的传入值在函数体中变为此类型的一个数组。例如，一个叫做 numbers 的 Double... 型可变参数，在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。
 
     func arithmeticMean(_ numbers: Double...) -> Double {
         var total: Double = 0
         for number in numbers {
             total += number
         }
         return total / Double(numbers.count)
     }
     arithmeticMean(1, 2, 3, 4, 5)
     // 返回 3.0, 是这 5 个数的平均数。
     arithmeticMean(3, 8.25, 18.75)
     // 返回 10.0, 是这 3 个数的平均数。
 
 - Note:
 一个函数只能有一个可变参数！
 */

//: ## `in-out` 参数
/*:
 函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。如果想要通过指针或者引用的方式读写一个参数，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。
 
 定义一个输入输出参数时，在参数定义前加 `inout` 关键字。
 
 调用函数时只能传递变量给 in-out 参数。不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改：
 
     func swapTwoInts(_ a: inout Int, _ b: inout Int) {
         let temporaryA = a
         a = b
         b = temporaryA
     }
 
     var someInt = 3
     var anotherInt = 107
     swapTwoInts(&someInt, &anotherInt)
     print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
     // 打印 "someInt is now 107, and anotherInt is now 3"
 
 - Note:
 输入输出参数不能有默认值，而且可变参数不能用 inout 标记。
 */
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//: ## 函数类型
/*:
 每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成：`func` `functionName(param1:` `Int`, `param2:` `Int)` `->` `Int` 函数的类型为：`(Int,` `Int)` `->` `Int`。
 
 在 `Swift` 中，使用函数类型就像使用其他类型一样。例如，你可以定义一个类型为函数的常量或变量，并将适当的函数赋值给它：
 
     var mathFunction: (Int, Int) -> Int = addTwoInts
 
 用 `(Int,` `Int) `->` `Int` 这样的函数类型作为另一个函数的参数类型：
 
     func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
         print("Result: \(mathFunction(a, b))")
     }
     printMathResult(addTwoInts, 3, 5)
     // 打印 "Result: 8"
 
 还可以用函数类型作为另一个函数的返回类型。需要做的是在返回箭头（->）后写一个完整的函数类型：
 
     func chooseStepFunction(backward: Bool) -> (Int) -> Int {
         return backward ? stepBackward : stepForward
     }
 
     var currentValue = 3
     let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
     // moveNearerToZero 现在指向 stepBackward() 函数。
 
 */

//: ## 嵌套函数
/*:
 在 `Swift` 中把函数定义在别的函数体中，称作 嵌套函数（nested functions）。
 
 默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用：
 
     func chooseStepFunction(backward: Bool) -> (Int) -> Int {
         func stepForward(input: Int) -> Int { return input + 1 }
         func stepBackward(input: Int) -> Int { return input - 1 }
         return backward ? stepBackward : stepForward
     }
     var currentValue = -4
     let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
     // moveNearerToZero now refers to the nested stepForward() function
     while currentValue != 0 {
         print("\(currentValue)... ")
         currentValue = moveNearerToZero(currentValue)
     }
     print("zero!")
     // -4...
     // -3...
     // -2...
     // -1...
     // zero!
 */
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
//: [下一页](@next)
