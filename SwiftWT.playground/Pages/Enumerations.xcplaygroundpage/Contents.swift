//
// Enumerations.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 枚举
/*:
 在 Swift 中，枚举类型是一等（first-class）类型；它采用了很多在传统上只被类（class）所支持的特性，例如计算属性（computed properties），用于提供枚举值的附加信息，实例方法（instance methods），用于提供和枚举值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始值；可以在原始实现的基础上扩展它们的功能；还可以遵循协议（protocols）来提供标准的功能。
 
 和 C 语言的枚举相比，Swift 中的枚举更加灵活，不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值（称为“原始”值），则该值的类型可以是字符串、字符，或是一个整型值或浮点数。
 
 此外，枚举成员可以指定任意类型的关联值存储到枚举成员中，就像其他语言中的联合体（unions）和变体（variants）。你可以在一个枚举中定义一组相关的枚举成员，每一个枚举成员都可以有适当类型的关联值。
 */

//: ## 枚举语法
/*:
 使用 enum 关键词来创建枚举并且把它们的整个定义放在一对大括号内：
 
     enum SomeEnumeration {
         // 枚举定义放在这里
     }
 
     enum CompassPoint {
         case north
         case south
         case east
         case west
     }
 
     var directionToHead = CompassPoint.west
 
     enum Planet {
         case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
     }
 
 枚举类型的变量声明为确定的类型之后，Swift 就可以使用类型推断的方式推断出值的类型：
 
     directionToHead = .east
 
 */

//: ## 使用 Switch 语句匹配枚举值
/*:
 可以使用 switch 语句匹配单个枚举值：
 
     directionToHead = .south
     switch directionToHead {
     case .north:
         print("Lots of planets have a north")
     case .south:
         print("Watch out for penguins")
     case .east:
         print("Where the sun rises")
     case .west:
         print("Where the skies are blue")
     }
     // 打印 "Watch out for penguins”
 
 */

//: ## 关联值
/*:
 可以定义 Swift 枚举来存储任意类型的关联值，每个枚举成员的关联值类型可以各不相同。枚举的这种特性跟其他语言中的可识别联合（discriminated unions），标签联合（tagged unions），或者变体（variants）相似：
 
     enum Barcode {
         case upc(Int, Int, Int, Int)
         case qrCode(String)
     }
 
     var productBarcode = Barcode.upc(8, 85909, 51226, 3)
     productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
 
 关联值可以被提取出来作为 switch 语句的一部分。在 switch 的 case 分支代码中提取每个关联值作为一个常量（用 let 前缀）或者作为一个变量（用 var 前缀）来使用：
 
     switch productBarcode {
     case .upc(let numberSystem, let manufacturer, let product, let check):
         print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
     case .qrCode(let productCode):
         print("QR code: \(productCode).")
     }
     // 打印 "QR code: ABCDEFGHIJKLMNOP."
 
 或者：
 
     switch productBarcode {
     case let .upc(numberSystem, manufacturer, product, check):
         print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
     case let .qrCode(productCode):
         print("QR code: \(productCode).")
     }
     // 输出 "QR code: ABCDEFGHIJKLMNOP."
 
 */

//: ## 原始值
/*:
 Swift 中，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同，声明原始值只需要在枚举定义后加上 `:` `RawValueType` 即可：
 
     enum ASCIIControlCharacter: Character {
         case tab = "\t"
         case lineFeed = "\n"
         case carriageReturn = "\r"
     }
 
 原始值可以是字符串、字符，或者任意整型值或浮点型值。原始值不需要显式地为每一个枚举成员设置原始值，Swift 将会自动赋值。
 
 声明为 `Int` 原始值的枚举跟 `C` 语言类似，第一个枚举值默认为 `0` ，往后递增，也可以指定某一个 `case` 的值往后递增：
 
     enum Planet: Int {
         case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
     }
 
 当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称：
 
     enum CompassPoint: String {
         case north, south, east, west
     }
 
 使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值：
 
     let earthsOrder = Planet.earth.rawValue
     // earthsOrder 值为 3
 
     let sunsetDirection = CompassPoint.west.rawValue
     // sunsetDirection 值为 "west"
 
 */

//: ## 使用原始值初始化枚举
/*:
 在定义枚举类型的时候使用原始值，就会自动生成一个初始化方法，这个方法接收一个叫做 rawValue 的参数，参数类型即为原始值类型，返回值则是一个可选的枚举类型：
 
     let possiblePlanet = Planet(rawValue: 7)
     // possiblePlanet 类型为 Planet? 值为 Planet.uranus
 
     let positionToFind = 11
     if let somePlanet = Planet(rawValue: positionToFind) {
         switch somePlanet {
         case .earth:
             print("Mostly harmless")
         default:
             print("Not a safe place for humans")
         }
     } else {
         print("There isn't a planet at position \(positionToFind)")
     }
     // 输出 "There isn't a planet at position 11
 
 */

//: ## 递归枚举
/*:
 递归枚举是一种枚举类型，枚举本身可以作为枚举定义的关联值，编译器会插入一个间接层。在枚举成员前加上 indirect 来表示该成员可递归：
 
     enum ArithmeticExpression {
         case number(Int)
         indirect case addition(ArithmeticExpression, ArithmeticExpression)
         indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
     }
 
 在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的：
 
     indirect enum ArithmeticExpression {
         case number(Int)
         case addition(ArithmeticExpression, ArithmeticExpression)
         case multiplication(ArithmeticExpression, ArithmeticExpression)
     }
 
     let five = ArithmeticExpression.number(5)
     let four = ArithmeticExpression.number(4)
     let sum = ArithmeticExpression.addition(five, four)
     let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
 
 */
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
//: [下一页](@next)
