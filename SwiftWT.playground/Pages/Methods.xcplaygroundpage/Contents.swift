//
// Methods.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 方法
/*:
 方法是与某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务与功能。类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联。类型方法与 Objective-C 中的类方法（class methods）相似。
 
 结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法。
 */

//: ## 实例方法
/*:
 实例方法是属于某个特定类、结构体或者枚举类型实例的方法。实例方法的语法与函数完全一致：
 
     class Counter {
         var count = 0
         func increment() {
             count += 1
         }
         func increment(by amount: Int) {
             count += amount
         }
         func reset() {
             count = 0
         }
     }
 
 和调用属性一样，用点语法（dot syntax）调用实例方法：
 
     let counter = Counter()
     // 初始计数值是0
     counter.increment()
     // 计数值现在是1
     counter.increment(by: 5)
     // 计数值现在是6
     counter.reset()
     // 计数值现在是0
 
 */

//: ## self 属性
/*:
 类型的每一个实例都有一个隐含属性叫做 self，self 完全等同于该实例本身。你可以在一个实例的实例方法中使用这个隐含的 self 属性来引用当前实例。在类型内部使用的时候可以省略！但是在方法参数名与属性名冲突时就不能省略，另外，在需要引用 self 的闭包(如逃逸闭包)里引用 self 时需要显式引用。
 
     struct Point {
         var x = 0.0, y = 0.0
         func isToTheRightOfX(_ x: Double) -> Bool {
             return self.x > x
         }
     }
     let somePoint = Point(x: 4.0, y: 5.0)
     if somePoint.isToTheRightOfX(1.0) {
     print("This point is to the right of the line where x == 1.0")
     }
     // 打印 "This point is to the right of the line where x == 1.0"
 
 */

//: ## 在实例方法中修改值类型
/*:
 结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。但是可以为方法添加 可变（mutating）行为，然后就可以从其方法内部改变它的属性；这时，方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例：
 
 要使用 可变方法，将关键字 mutating 放到方法的 func 关键字之前就可以了：
 
     struct Point {
         var x = 0.0, y = 0.0
         mutating func moveByX(_ deltaX: Double, y deltaY: Double) {
             x += deltaX
             y += deltaY
         }
     }
     var somePoint = Point(x: 1.0, y: 1.0)
     somePoint.moveByX(2.0, y: 3.0)
     print("The point is now at (\(somePoint.x), \(somePoint.y))")
     // 打印 "The point is now at (3.0, 4.0)"
 
     struct Point {
         var x = 0.0, y = 0.0
         mutating func moveBy(x deltaX: Double, y deltaY: Double) {
             self = Point(x: x + deltaX, y: y + deltaY)
         }
     }
 
     enum TriStateSwitch {
         case Off, Low, High
         mutating func next() {
             switch self {
             case .Off:
                 self = .Low
             case .Low:
                 self = .High
             case .High:
                 self = .Off
             }
         }
     }
     var ovenLight = TriStateSwitch.Low
     ovenLight.next()
     // ovenLight 现在等于 .High
     ovenLight.next()
     // ovenLight 现在等于 .Off
 
 */

//: ## 类型方法
/*:
 定义在类型本身上调用的方法，这种方法就叫做类型方法。在方法的 func 关键字之前加上关键字 static，来指定类型方法。类还可以用关键字 class 来允许子类重写父类的方法实现；类型方法中的 self 指向类型本身：
 
     class SomeClass {
         class func someTypeMethod() {
             // 在这里实现类型方法
         }
     }
     SomeClass.someTypeMethod()
 
 */
//: [下一页](@next)
