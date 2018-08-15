//
// Memory-Safety.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 内存安全
/*:
 默认情况下，Swift 会阻止代码里不安全的行为。例如，Swift 会保证变量在使用之前就完成初始化，在内存被回收之后就无法被访问，并且数组的索引会做越界检查。
 
 Swift 也保证同时访问同一块内存时不会冲突，通过约束代码里对于存储地址的写操作，去获取那一块内存的访问独占权。因为 Swift 自动管理内存，所以大部分时候我们完全不需要考虑内存访问的事情。然而，理解潜在的冲突也是很重要的，可以避免写出访问冲突的代码。而如果你的代码确实存在冲突，那在编译时或者运行时就会得到错误。
 */
//: ## 内存访问冲突
/*:
 内存的访问，会发生在你给变量赋值，或者传递参数给函数时：
 
     // 向 one 所在的内存区域发起一次写操作
     var one = 1
 
     // 向 one 所在的内存区域发起一次读操作
     print("We're number \(one)!")
 
 内存访问的冲突会发生在代码尝试同时访问同一个存储地址的时侯。同一个存储地址的多个访问同时发生会造成不可预计或不一致的行为。在 Swift 里，有很多修改值的行为都会持续好几行代码，在修改值的过程中进行访问是有可能发生的。
 
 - Note:
 这里访问冲突的讨论是在单线程的情境下讨论的，并没有使用并发或者多线程。
 如果你曾经在单线程代码里有访问冲突，Swift 可以保证你在编译或者运行时会得到错误。对于多线程的代码，可以使用 Thread Sanitizer 去帮助检测多线程的冲突。
 */
//: ## 内存访问的典型状况
/*:
 内存访问冲突有三种典型的状况：访问是读还是写，访问的时长，以及被访问的存储地址。特别是，当有两个访问符合下列的情况：
 - 至少有一个是写访问
 - 它们访问的是同一个存储地址
 - 它们的访问在时间线上部分重叠
 
 读和写访问的区别很明显：一个写访问会改变存储地址，而读操作不会。存储地址会指向真正访问的位置 —— 例如，一个变量，常量或者属性。内存访问的时长要么是瞬时的，要么是长期的。
 
 如果一个访问不可能在其访问期间被其它代码访问，那么就是一个瞬时访问。基于这个特性，两个瞬时访问是不可能同时发生。大多数内存访问都是瞬时的。例如，下面列举的所有读和写访问都是瞬时的：
 
     func oneMore(than number: Int) -> Int {
         return number + 1
     }
 
     var myNumber = 1
     myNumber = oneMore(than: myNumber)
     print(myNumber)
     // 打印 "2"
 
 然而，有几种被称为长期访问的内存访问方式，会在别的代码执行时持续进行。瞬时访问和长期访问的区别在于别的代码有没有可能在访问期间同时访问，也就是在时间线上的重叠。一个长期访问可以被别的长期访问或瞬时访问重叠。
 
 重叠的访问主要出现在使用 in-out 参数的函数和方法或者结构体的 mutating 方法里。Swift 代码里典型的长期访问会在后面进行讨论。
 */
//: ## In-Out 参数的访问冲突
/*:
 一个函数会对它所有的 in-out 参数进行长期写访问。in-out 参数的写访问会在所有非 in-out 参数处理完之后开始，直到函数执行完毕为止。如果有多个 in-out 参数，则写访问开始的顺序与参数的顺序一致。
 
 长期访问的存在会造成一个结果，你不能在原变量以 in-out 形式传入后访问原变量，即使作用域原则和访问权限允许 —— 任何访问原变量的行为都会造成冲突。例如：
 
     var stepSize = 1
 
     func increment(_ number: inout Int) {
         number += stepSize
     }
 
     increment(&stepSize)
     // 错误：stepSize 访问冲突
 
 解决这个冲突的一种方式，是复制一份 stepSize 的副本：
 
     // 复制一份副本
     var copyOfStepSize = stepSize
     increment(&copyOfStepSize)
 
     // 更新原来的值
     stepSize = copyOfStepSize
     // stepSize 现在的值是 2
 
 长期写访问的存在还会造成另一种结果，往同一个函数的多个 in-out 参数里传入同一个变量也会产生冲突，例如：
 
     func balance(_ x: inout Int, _ y: inout Int) {
         let sum = x + y
         x = sum / 2
         y = sum - x
     }
     var playerOneScore = 42
     var playerTwoScore = 30
     balance(&playerOneScore, &playerTwoScore)  // 正常
     balance(&playerOneScore, &playerOneScore)
     // 错误：playerOneScore 访问冲突
 
 将 playerOneScore 和 playerTwoScore 作为参数传入不会产生错误 —— 有两个访问重叠了，但它们访问的是不同的内存位置。相反，将 playerOneScore 作为参数同时传入就会产生冲突，因为它会发起两个写访问，同时访问同一个的存储地址。
 
 - Note:
 因为操作符也是函数，它们也会对 in-out 参数进行长期访问。
 */
//: ### 方法里 self 的访问冲突
/*:
 一个结构体的 mutating 方法会在调用期间对 self 进行写访问。例如，想象一下这么一个游戏，每一个玩家都有血量，受攻击时血量会下降，并且有敌人的数量，使用特殊技能时会减少敌人数量。
 
     struct Player {
         var name: String
         var health: Int
         var energy: Int
 
         static let maxHealth = 10
         mutating func restoreHealth() {
             health = Player.maxHealth
         }
     }
 
 在上面的 restoreHealth() 方法里，一个对于 self 的写访问会从方法开始直到方法 return。在这种情况下，restoreHealth() 里的其它代码不可以对 Player 实例的属性发起重叠的访问。下面的 shareHealth(with:) 方法接受另一个 Player 的实例作为 in-out 参数，产生了访问重叠的可能性。
 
     extension Player {
         mutating func shareHealth(with teammate: inout Player) {
             balance(&teammate.health, &health)
         }
     }
 
     var oscar = Player(name: "Oscar", health: 10, energy: 10)
     var maria = Player(name: "Maria", health: 5, energy: 10)
     oscar.shareHealth(with: &maria)  // 正常
 
 调用 shareHealth(with:) 方法去把 oscar 玩家的血量分享给 maria 玩家并不会造成冲突。在方法调用期间会对 oscar 发起写访问，因为在 mutating 方法里 self 就是 oscar，同时对于 maria 也会发起写访问，因为 maria 作为 in-out 参数传入。过程如下，它们会访问内存的不同位置。即使两个写访问重叠了，它们也不会冲突。
 
 如果你将 oscar 作为参数传入 shareHealth(with:) 里，就会产生冲突：
 
     oscar.shareHealth(with: &oscar)
     // 错误：oscar 访问冲突
 
 mutating 方法在调用期间需要对 self 发起写访问，而同时 in-out 参数也需要写访问。在方法里，self 和 teammate 都指向了同一个存储地址，对于同一块内存同时进行两个写访问，并且它们重叠了，就此产生了冲突。
 */
//: ### 属性的访问冲突
/*:
 如结构体，元组和枚举的类型都是由多个独立的值组成的，例如结构体的属性或元组的元素。因为它们都是值类型，修改值的任何一部分都是对于整个值的修改，意味着其中一个属性的读或写访问都需要访问整一个值。例如，元组元素的写访问重叠会产生冲突：
 
     var playerInformation = (health: 10, energy: 20)
     balance(&playerInformation.health, &playerInformation.energy)
     // 错误：playerInformation 的属性访问冲突
 
 下面的代码展示了一样的错误，对于一个存储在全局变量里的结构体属性的写访问重叠了。
 
     var holly = Player(name: "Holly", health: 10, energy: 10)
     balance(&holly.health, &holly.energy)  // 错误
 
 大多数对于结构体属性的访问都会安全的重叠。例如，将上面例子里的变量 holly 改为本地变量而非全局变量，编译器就会可以保证这个重叠访问时安全的：
 
     func someFunction() {
         var oscar = Player(name: "Oscar", health: 10, energy: 10)
         balance(&oscar.health, &oscar.energy)  // 正常
     }
 
 oscar 的 health 和 energy 都作为 in-out 参数传入了 balance(_:_:) 里。编译器可以保证内存安全，因为两个存储属性任何情况下都不会相互影响。
 */
/*:
 限制结构体属性的重叠访问对于内存安全并不总是必要的。内存安全很有必要，但访问独占权的要求比内存安全还要更严格 —— 意味着即使有些代码违反了访问独占权的原则，也是内存安全的。如果编译器可以保证这种非专属的访问是安全的，那 Swift 就会允许这种内存安全的行为。特别是当遵循下面的原则时，它可以保证结构体属性的重叠访问是安全的：
 
 - 你访问的是实例的存储属性，而不是计算属性或类的属性
 - 结构体是本地变量的值，而非全局变量
 - 结构体要么没有被闭包捕获，要么只被非逃逸闭包捕获了
 
 如果编译器无法保证访问的安全性，它就不会允许访问。
 */
//: [下一页](@next)
