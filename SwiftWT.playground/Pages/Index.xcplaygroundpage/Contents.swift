//
// Index.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: # ![Swift-Icon](swift-icon.png) Swift Basic
/*:
 `Swift`是`Apple`于`2014`年推出的新语言，于`2015`年开源，经过几年的发展，现在`Swift`已经越来越成熟。`Swift`不仅可以用来开发基于`CocoaTouch`的`iOS`应用，还能作为一门脚本语言和后端语言，在开源社区，已有了很多比较成熟的后端开发框架，如[`Perfect`](https://github.com/PerfectlySoft/Perfect)、[`Vapor`](https://github.com/vapor/vapor)、[`Kitura`](https://github.com/IBM-Swift/Kitura)、[`Taylor`](https://github.com/izqui/Taylor)等，但是生态发展还不成熟，而且官方的推动也需要时间；`Swift`设计就是一门脚本语言，虽然不像`Python`、`Ruby`等语言发展成熟，但是`Swift`作为脚本语言还是有很深的潜力，像现在很多工具都是`Swift`开发的，如`SwiftLint`、`Carthage`等工具.
 
 `Swift`是一门静态语言，所有类型、属性和方法都必须在编译期确定下来；`Swift`是一门强类型语言，每一个变量、实例都有自己的类型，而且对类型特别敏感，没有类型容错；`Swift`是一门高效的语言，所有方法的分发都是在编译期确定的，没有`OC`的运行时发送消息的机制，同时，这也让`Swift`变得安全，大部分错误都能在编译期暴露出来，非常适合构建大型项目，能够很大程度的提升代码的健壮性；`Swift`还支持多种编程范式，如函数式编程、泛型编程等，这些编程范式可以大大提高开发效率；但是`Swift`也有很多诟病，从`Swift` `1.0`到现在的`Swift` `4.0`，一直在更改API和添加特性，这让`Swift`变得越来越复杂和难以理解，但是，从经验来看，很多特性确实能够节省很多的开发时间，所以，还得辩证的看待这个事情.
 
 `Swift`拥有很多特性，上述已经列举部分，引用`Swift`官方文档，`Swift`是一门现代语言，体现在以下几点：
 - 安全.
 - **`Fast`**：译为高效，但是也包含字面意义的快速；对比很多脚本语言甚至主流的`Java`等语言，`Swift`在高效这个层面做得确实很到位.
 - 可读、易使用：`Swift`吸取了很多语言的语法和编程习惯，大杂烩.
 
 `Swift`除了支出很多编程语言最基本的东西之外，还引入了很多特性，如：模块化(去除头文件)、命名空间以及借鉴的其他语言的很多特性，这些特性可以帮助我们编写很多高效、优雅的代码，相比很多C(特别是OC)家族的语言，`Swift`还有如下特点：
 - 函数、闭包是一等公民
 - 支持元组类型和函数多返回值(`Python`)
 - 泛型编程：泛型协议、泛型类型、泛型方法
 - 函数式编程：标准库内建方法：`map`、`filter`、`reduce`等
 - 快速简洁的集合类型遍历语法
 - 结构体可以支持方法定义、类型扩展、实现协议
 - 强大的错误处理机制
 - 高级流程控制语法，如：`guard`、`do`、`defer`、`repeat`
 */
/*:
 ## 平台支持
 - `MacOS`
 - `Linux`
 */
/*:
 - Callout(Swift.org Projects):
 The Swift language is managed as a collection of projects, each with its own repositories. The current list of projects includes:
 
 - The [Swift compiler](https://swift.org/compiler-stdlib/) command line tool
 - The [standard library](https://swift.org/compiler-stdlib/) bundled as part of the language
 - [Core libraries](https://swift.org/core-libraries/) that provide higher-level functionality
 - The [LLDB debugger](https://swift.org/lldb/) which includes the Swift REPL
 - The [Swift package manager](https://swift.org/package-manager/) for distributing and building Swift source code
 - [Xcode playground support](https://swift.org/lldb/#xcode-playground-support) to enable playgrounds in Xcode.
 */
/*:
 ## 目录
 [`Swift`基础部分](Basics)
 
 [基本运算符](Basic%20Operators)
 
 [字符与字符串](Strings%20and%20Characters)
 
 [集合类型](Collection%20Types)
 
 [控制流](Control%20Flow)
 
 [函数](Functions)
 
 [闭包](Closures)
 
 [枚举](Enumerations)
 
 [类和结构体](Structures%20and%20Classes)
 
 [属性](Properties)
 
 [方法](Methods)
 
 [下标](Subscripts)
 
 [继承](Inheritance)
 
 [构造器](Initialization)
 
 [销毁器](Deinitialization)
 
 [可选链](Optional%20Chaining)
 
 [错误处理](Error%20Handling)
 
 [类型嵌套](Nested%20Types)
 
 [扩展](Extensions)
 
 [协议](Protocols)
 
 [泛型](Generics)
 
 [内存管理](Automatic%20Reference%20Counting)
 
 [内存安全](Memory%20Safety)
 
 [访问控制](Access%20Control)
 
 [高级运算符](Advanced%20Operators)
 */
//: [下一页](@next)

