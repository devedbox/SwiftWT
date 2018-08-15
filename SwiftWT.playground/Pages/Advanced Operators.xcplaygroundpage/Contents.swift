//
// Advanced-Operators.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 高级运算符
/*:
 自定义结构体、类和枚举时，如果也为它们提供标准 Swift 运算符的实现，将会非常有用。在 Swift 中自定义运算符非常简单，运算符也会针对不同类型使用对应实现。
 
 我们不用被预定义的运算符所限制。在 Swift 中可以自由地定义中缀、前缀、后缀和赋值运算符，以及相应的优先级与结合性。这些运算符在代码中可以像预定义的运算符一样使用，我们甚至可以扩展已有的类型以支持自定义的运算符。
 */
//: ## 运算符函数
/*:
 类和结构体可以为现有的运算符提供自定义的实现，这通常被称为运算符重载。
 
 - Note:
 不能对默认的赋值运算符（=）进行重载。只有组合赋值运算符可以被重载。同样地，也无法对三目条件运算符 （a ? b : c） 进行重载。
 
 示例：
 
     struct Vector2D {
         var x = 0.0, y = 0.0
     }
 
     extension Vector2D {
         static func + (left: Vector2D, right: Vector2D) -> Vector2D {
             return Vector2D(x: left.x + right.x, y: left.y + right.y)
         }
     }
 
     let vector = Vector2D(x: 3.0, y: 1.0)
     let anotherVector = Vector2D(x: 2.0, y: 4.0)
     let combinedVector = vector + anotherVector
     // combinedVector 是一个新的 Vector2D 实例，值为 (5.0, 5.0)
 
 */

//: ## 前缀和后缀运算符
/*:
 类与结构体也能提供标准单目运算符的实现。单目运算符只运算一个值。当运算符出现在值之前时，它就是前缀的（例如 -a），而当它出现在值之后时，它就是后缀的（例如 b!）。
 
 要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 修饰符：
 
     extension Vector2D {
         static prefix func - (vector: Vector2D) -> Vector2D {
             return Vector2D(x: -vector.x, y: -vector.y)
         }
     }
 
     let positive = Vector2D(x: 3.0, y: 4.0)
     let negative = -positive
     // negative 是一个值为 (-3.0, -4.0) 的 Vector2D 实例
     let alsoPositive = -negative
     // alsoPositive 是一个值为 (3.0, 4.0) 的 Vector2D 实例
 
 */

//: ## 复合赋值运算符
/*:
 复合赋值运算符将赋值运算符（=）与其它运算符进行结合。例如，将加法与赋值结合成加法赋值运算符（+=）。在实现的时候，需要把运算符的左参数设置成 inout 类型，因为这个参数的值会在运算符函数内直接被修改。
 
     extension Vector2D {
         static func += (left: inout Vector2D, right: Vector2D) {
             left = left + right
         }
     }
 
     var original = Vector2D(x: 1.0, y: 2.0)
     let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
     original += vectorToAdd
     // original 的值现在为 (4.0, 6.0)
 
 */

//: ## 等价运算符
/*:
 自定义的类和结构体没有对等价运算符进行默认实现，等价运算符通常被称为“相等”运算符（==）与“不等”运算符（!=）。对于自定义类型，Swift 无法判断其是否“相等”，因为“相等”的含义取决于这些自定义类型在你的代码中所扮演的角色。
 
 为了使用等价运算符能对自定义的类型进行判等运算，需要为其提供自定义实现，实现的方法与其它中缀运算符一样, 并且增加对标准库 Equatable 协议的遵循：
 
     extension Vector2D: Equatable {
         static func == (left: Vector2D, right: Vector2D) -> Bool {
             return (left.x == right.x) && (left.y == right.y)
         }
     }
 
     let twoThree = Vector2D(x: 2.0, y: 3.0)
     let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
     if twoThree == anotherTwoThree {
     print("These two vectors are equivalent.")
     }
     // 打印 “These two vectors are equivalent.”
 
 Swift 为以下自定义类型等价运算符提供合成实现：
 - 只拥有遵循 Equatable 协议存储属性的结构体；
 - 只拥有遵循 Equatable 协议关联类型的枚举；
 - 没有关联类型的枚举。
 
 在类型原本的声明中声明遵循 Equatable 来接收这些默认实现。
 
     struct Vector3D: Equatable {
         var x = 0.0, y = 0.0, z = 0.0
     }
 
     let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
     let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
     if twoThreeFour == anotherTwoThreeFour {
         print("These two vectors are also equivalent.")
     }
     // Prints "These two vectors are also equivalent."
 
 */

//: ## 自定义运算符
/*:
 除了实现标准运算符，在 Swift 中还可以声明和实现自定义运算符。
 
 新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符：
 
     prefix operator +++
 
     extension Vector2D {
         static prefix func +++ (vector: inout Vector2D) -> Vector2D {
             vector += vector
             return vector
         }
     }
 
     var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
     let afterDoubling = +++toBeDoubled
     // toBeDoubled 现在的值为 (2.0, 8.0)
     // afterDoubling 现在的值也为 (2.0, 8.0)
 
 */

//: ## 自定义中缀运算符的优先级
/*:
 每个自定义中缀运算符都属于某个优先级组。这个优先级组指定了这个运算符和其他中缀运算符的优先级和结合性。没有明确放入优先级组的自定义中缀运算符会放到一个默认的优先级组内，其优先级高于三元运算符。
 
 定义了一个新的自定义中缀运算符 +-，此运算符属于 AdditionPrecedence 优先组：
 
     infix operator +-: AdditionPrecedence
     extension Vector2D {
         static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
             return Vector2D(x: left.x + right.x, y: left.y - right.y)
         }
     }
 
     let firstVector = Vector2D(x: 1.0, y: 2.0)
     let secondVector = Vector2D(x: 3.0, y: 4.0)
     let plusMinusVector = firstVector +- secondVector
     // plusMinusVector 是一个 Vector2D 实例，并且它的值为 (4.0, -2.0)
 
 */
//: [下一页](@next)
