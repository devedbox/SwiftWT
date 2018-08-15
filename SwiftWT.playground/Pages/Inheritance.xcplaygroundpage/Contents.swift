//
// Inheritance.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 继承
/*:
 一个类可以继承另一个类的方法，属性和其它特性。在 Swift 中，继承是区分「类」与其它类型的一个基本特征。
 
 在 Swift 中，类可以调用和访问父类的方法、属性和下标，并且可以重写这些方法、属性和下标来优化或修改它们的行为。Swift 会检查重写定义在父类中是否有匹配的定义，以确保重写是正确的。
 
 可以为类中继承来的属性添加属性观察器，这样，当属性值改变时，类就会收到通知；可以为任何属性添加属性观察器，存储型属性和计算型属性均可。
 
 */

//: ## 基类
/*:
 不继承于其它类的类，称为基类：
 
     class Vehicle {
         var currentSpeed = 0.0
         var description: String {
             return "traveling at \(currentSpeed) miles per hour"
         }
         func makeNoise() {
             // 什么也不做-因为车辆不一定会有噪音
         }
     }
 
 - Note:
 Swift 中的类并不是从一个通用的基类（如 `NSObject` ）继承而来。如果不为定义的类指定一个父类的话，这个类就自动成为基类。
 */

//: ## 子类派生
/*:
 指定某个类的父类，只需将父类名写在子类名的后面，用冒号分隔即可：
 
     class SomeClass: SomeSuperclass {
         // 这里是子类的定义
     }
 
 举个例子：
 
     class Bicycle: Vehicle {
         var hasBasket = false
     }
 
     let bicycle = Bicycle()
     bicycle.hasBasket = true
 
     bicycle.currentSpeed = 15.0
     print("Bicycle: \(bicycle.description)")
     // 打印 "Bicycle: traveling at 15.0 miles per hour"
 
*/

//: ## Override
/*:
 子类可以为继承来的实例方法，类方法，实例属性，或下标提供自己定制的实现。重写某个特性，需要在重写定义的前面加上 override 关键字。意外的重写行为可能会导致不可预知的错误，任何缺少 override 关键字的重写都会在编译时被报错。
 
 ### 访问父类的方法，属性及下标
 通过使用 super 前缀来访问父类版本的方法，属性或下标：
 - 通过 super.someMethod() 来调用父类版本的 someMethod() 方法。
 - 通过 super.someProperty 来访问父类版本的 someProperty 属性。
 - 通过 super[someIndex] 来访问父类版本中的相同下标。
 
 */

//: ### 重写方法
/*:
 在子类中，你可以重写继承来的实例方法或类方法，提供一个定制或替代的方法实现：
 
     class Train: Vehicle {
         override func makeNoise() {
             print("Choo Choo")
         }
     }
 
     let train = Train()
     train.makeNoise()
     // 打印 "Choo Choo"
 
 */

//: ### 重写属性
/*:
 可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter，或添加属性观察器使重写的属性可以观察属性值什么时候发生改变。
 */
//: #### 重写属性的 Getters 和 Setters
/*:
 提供定制的 getter（或 setter）来重写任意继承来的属性，重写一个属性时，必需将它的名字和类型都写出来。
 
 可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。
 
     class Car: Vehicle {
         var gear = 1
         override var description: String {
             return super.description + " in gear \(gear)"
         }
     }
 
     let car = Car()
     car.currentSpeed = 25.0
     car.gear = 3
     print("Car: \(car.description)")
     // 打印 "Car: traveling at 25.0 miles per hour in gear 3"
 
 - Note:
 如果你在重写属性中提供了 setter，那么你也一定要提供 getter。
 */
//: #### 重写属性观察器
/*:
 可以通过重写属性为一个继承来的属性添加属性观察器：
 
     class AutomaticCar: Car {
         override var currentSpeed: Double {
             didSet {
                 gear = Int(currentSpeed / 10.0) + 1
             }
         }
     }
 
     let automatic = AutomaticCar()
     automatic.currentSpeed = 35.0
     print("AutomaticCar: \(automatic.description)")
     // 打印 "AutomaticCar: traveling at 35.0 miles per hour in gear 4"
 
 - Note:
 需要注意，不可以同时提供重写的 setter 和重写的属性观察器。
 */
//: ## 防止Override
/*:
 通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上 final 修饰符即可（例如：final var，final func，final class func，以及 final subscript）。
 
 通过在关键字 class 前添加 final 修饰符（final class）来将整个类标记为 final 的。这样的类是不可被继承的。
 */
//: [下一页](@next)
