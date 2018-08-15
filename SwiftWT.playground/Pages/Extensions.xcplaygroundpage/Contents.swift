//
// Extensions.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 扩展
/*:
 *扩展*就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。可以在没有权限获取原始源代码的情况下扩展类型的能力（即 逆向建模 ）。扩展和 Objective-C 中的分类类似。（与 Objective-C 不同的是，Swift 的扩展没有名字。）
 
 Swift 中的扩展可以：
 
 - 添加计算型属性和计算型类型属性
 - 定义实例方法和类型方法
 - 提供新的构造器
 - 定义下标
 - 定义和使用新的嵌套类型
 - 使一个已有类型符合某个协议
 - 在 Swift 中，甚至可以对协议进行扩展，提供协议要求的实现，或者添加额外的功能，从而可以让符合协议的类型拥有这些功能
 
 - Note:
 扩展可以为一个类型添加新的功能，但是不能重写已有的功能。
 */

//: ## 扩展语法
/*:
 使用关键字 extension 来声明扩展：
 
     extension SomeType {
         // 为 SomeType 添加的新功能写到这里
     }
 
 可以通过扩展来扩展一个已有类型，使其实现一个或多个协议：
 
     extension SomeType: SomeProtocol, AnotherProctocol {
         // 协议实现写到这里
     }
 
 - Note:
 扩展添加的新功能对该类型的所有已有实例都是可用的，即使它们是在这个扩展定义之前创建的。
 */

//: ## 计算型属性
/*:
 扩展可以为已有类型添加计算型实例属性和计算型类型属性：
 
     extension Double {
         var km: Double { return self * 1_000.0 }
         var m : Double { return self }
         var cm: Double { return self / 100.0 }
         var mm: Double { return self / 1_000.0 }
         var ft: Double { return self / 3.28084 }
     }
     let oneInch = 25.4.mm
     print("One inch is \(oneInch) meters")
     // 打印 “One inch is 0.0254 meters”
     let threeFeet = 3.ft
     print("Three feet is \(threeFeet) meters")
     // 打印 “Three feet is 0.914399970739201 meters”
 
     let aMarathon = 42.km + 195.m
     print("A marathon is \(aMarathon) meters long")
     // 打印 “A marathon is 42195.0 meters long”
 
 - Note:
 扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。
 */
extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
//: ## 构造器
/*:
 扩展可以为已有类型添加新的构造器，对于类类型而言，则只能添加便利构造器，不能添加指定构造器和析构器，这两者只能定义在类的定义里边：
 
     struct Size {
         var width = 0.0, height = 0.0
     }
     struct Point {
         var x = 0.0, y = 0.0
     }
     struct Rect {
         var origin = Point()
         var size = Size()
     }
 
     let defaultRect = Rect()
     let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
     size: Size(width: 5.0, height: 5.0))
 
     extension Rect {
         init(center: Point, size: Size) {
             let originX = center.x - (size.width / 2)
             let originY = center.y - (size.height / 2)
             self.init(origin: Point(x: originX, y: originY), size: size)
         }
     }
 
     let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
     size: Size(width: 3.0, height: 3.0))
     // centerRect 的原点是 (2.5, 2.5)，大小是 (3.0, 3.0)
 */
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

//: ## 方法
/*:
 扩展可以为已有类型添加新的实例方法和类型方法：
 
     extension Int {
         func repetitions(task: () -> Void) {
             for _ in 0..<self {
                 task()
             }
         }
     }
 
     3.repetitions({
         print("Hello!")
     })
     // Hello!
     // Hello!
     // Hello!
 
     extension Int {
         mutating func square() {
             self = self * self
         }
     }
     var someInt = 3
     someInt.square()
     // someInt 的值现在是 9
 
 */
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}

extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
//: ## 下标
/*:
 扩展可以为已有类型添加新下标：
 
     extension Int {
         subscript(digitIndex: Int) -> Int {
             var decimalBase = 1
             for _ in 0..<digitIndex {
                 decimalBase *= 10
             }
             return (self / decimalBase) % 10
         }
     }
     746381295[0]
     // 返回 5
     746381295[1]
     // 返回 9
     746381295[2]
     // 返回 2
     746381295[8]
     // 返回 7
 
 */
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
746381295[1]
746381295[2]
746381295[8]
//: ## 嵌套类型
/*:
 扩展可以为已有的类、结构体和枚举添加新的嵌套类型：
 
     extension Int {
         enum Kind {
         case negative, zero, positive
         }
         var kind: Kind {
             switch self {
             case 0:
                 return .zero
             case let x where x > 0:
                 return .positive
             default:
                 return .negative
             }
         }
     }
 
     func printIntegerKinds(_ numbers: [Int]) {
         for number in numbers {
         switch number.kind {
         case .negative:
             print("- ", terminator: "")
         case .zero:
             print("0 ", terminator: "")
         case .positive:
             print("+ ", terminator: "")
         }
         }
         print("")
     }
     printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
     // 打印 “+ + - 0 - 0 + ”
 
 */
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
//: [下一页](@next)
