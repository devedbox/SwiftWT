//: [Previous](@previous)

import Foundation

//: # 类型系统
/*:
 Swift 是一门强类型语言，在 Swift 的世界中，一切皆类型，每个变量都有确定的类型，而且每个类型也有自己的类型。Swift 的强类型特性衍生出来其他的一些特性，最常见和常用的就是我们的*类型推断*，类型推断可以通过代码的上下文信息推断出代码的执行结果的类型，这在 Swift 的代码中很常用；类型推断还可以使用在函数(属性)调用以及枚举类型上，如枚举类型可以在编写的时候省略枚举类型的声明而直接使用 `.case` 的形式来使用。
 
 Swift 中的类型系统很强大、很智能，它总是会向我们传达一个消息：“我知道你的类型”，而不是：“请告诉我你的类型”，我们在编写 OC 的代码的时候，类型总是由我们告知编译器的，但是在 Swift 中，我们总算可以解放了~
 
 在 Swift 中一定要铭记类型的重要性，类型贯穿了整个 Swift 的所有特性，为什么说 Swift 安全，Swift 的安全性最明确的提现就是在类型的处理上，一个 `Int` 类型的变量只接受 `Int` 类型的值，尝试传递其他类型的值是不被允许的，而且在编译期间就可以将这类问题暴露出来，不会等到运行时出现问题了毫不留情的给我们来一个`crash`。
 
 因此，在编写 Swift 代码时一定要将思路转变过来，不要使用动态语言的思维去编写 Swift 代码，因为 Swift 是一门静态强类型语言！
 */
//: ## 类型推断
/*:
 类型推断可以在不显式指定类型的情况下由类型推断系统推断出类型，这个特性可以帮助我们编写出简洁的代码。创建一个变量：
 */
let intVal: Int = 1
let floatVal: Float = 1 // 
let doubleVal: Float = 1
//: 使用类型推断：
let intValue = 1
let floatValue = 1.0
let doubleValue = 1.0
//: 需要注意的是，在使用类型推断的时候，Swift 会以最大兼容性来推断数值字面量的类型，什么意思呢？浮点型字面量永远会被推断为 `Double` 类型而非 `Float` 类型。
//: [Next](@next)
