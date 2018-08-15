//
// Generics.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 泛型
/*:
 泛型代码让我们能够根据自定义的需求，编写出适用于任意类型、灵活可重用的函数及类型。它能让我们避免代码的重复，用一种清晰和抽象的方式来表达代码的意图。
 
 泛型是 Swift 最强大的特性之一，许多 Swift 标准库是通过泛型代码构建的，例如，Swift 的 Array 和 Dictionary 都是泛型集合。可以创建一个 Int 数组，也可创建一个 String 数组，甚至可以是任意其他 Swift 类型的数组。同样的，也可以创建存储任意指定类型的字典。
 
 ## 泛型解决的问题
 
 下面是一个标准的非泛型函数 swapTwoInts(_:_:)，用来交换两个 Int 值：
 
     func swapTwoInts(_ a: inout Int, _ b: inout Int) {
         let temporaryA = a
         a = b
         b = temporaryA
     }
 
     var someInt = 3
     var anotherInt = 107
     swapTwoInts(&someInt, &anotherInt)
     print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
     // 打印 “someInt is now 107, and anotherInt is now 3”
 
 这种方式的缺点很明显，这个方式只能在 Int 类型中使用，当我们需要使用别的类型的时候，就需要重新定义一个相应的类型的方法。而是用泛型，则只需要定义一个方法即可。
 */

//: ## 泛型函数
/*:
 和普通函数相比，泛型函数可以使用与任意的类型：
 
     func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
         let temporaryA = a
         a = b
         b = temporaryA
     }
 
     var someInt = 3
     var anotherInt = 107
     swapTwoValues(&someInt, &anotherInt)
     // someInt 现在 107, and anotherInt 现在 3
 
     var someString = "hello"
     var anotherString = "world"
     swapTwoValues(&someString, &anotherString)
     // someString 现在 "world", and anotherString 现在 "hello"
 
 */

//: ## 类型参数
/*:
 在上面的 swapTwoValues(_:_:) 例子中，占位类型 T 是**类型参数**的一个例子。类型参数指定并命名一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来（例如 <T>）。
 
 一旦一个类型参数被指定，就可以用它来定义一个函数的参数类型（例如 swapTwoValues(_:_:) 函数中的参数 a 和 b），或者作为函数的返回类型，还可以用作函数体变量类型。在这些情况下，类型参数会在函数调用时被实际类型所替换。
 
 可以提供多个类型参数，将它们都写在尖括号中，用逗号分开。
 */

//: ## 泛型类型
/*:
 Swift 还可以定义泛型类型。泛型类、结构体和枚举可以适用于任何类型，类似于 Array 和 Dictionary。
 
 定义一个 Stack ：
 
     struct IntStack {
         var items = [Int]()
         mutating func push(_ item: Int) {
             items.append(item)
         }
         mutating func pop() -> Int {
             return items.removeLast()
         }
     }
 
 泛型版本：
 
     struct Stack<Element> {
         var items = [Element]()
         mutating func push(_ item: Element) {
             items.append(item)
         }
         mutating func pop() -> Element {
             return items.removeLast()
         }
     }
 */

//: ## 泛型类型的扩展
/*:
 当扩展一个泛型类型的时候，并不需要在扩展的定义中提供*类型参数（列表。类型定义中声明的类型参数列表在扩展中可以直接使用：
 
     extension Stack {
         var topItem: Element? {
             return items.isEmpty ? nil : items[items.count - 1]
         }
     }
 
     if let topItem = stackOfStrings.topItem {
         print("The top item on the stack is \(topItem).")
     }
     // 打印 “The top item on the stack is tres.”
 
 */

//: ## 类型约束
/*:
 类型约束可以指定一个类型参数必须继承自指定类，或者符合一个特定的协议或协议组合。
 
 可以在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束，它们将成为类型参数列表的一部分。对泛型函数添加类型约束的基本语法如下所示（作用于泛型类型时的语法与之相同）：
 
     func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
         // 这里是泛型函数的函数体部分
     }
 
 示例：
 
     func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
         for (index, value) in array.enumerated() {
             if value == valueToFind {
                 return index
             }
         }
         return nil
     }
 
     let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
     if let foundIndex = findIndex(ofString: "llama", in: strings) {
         print("The index of llama is \(foundIndex)")
     }
     // 打印 “The index of llama is 2”
 
 使用类型约束的泛型版本：
 
     func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
         for (index, value) in array.enumerated() {
             if value == valueToFind {
                 return index
             }
         }
         return nil
     }
 
     let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
     // doubleIndex 类型为 Int?，其值为 nil，因为 9.3 不在数组中
     let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
     // stringIndex 类型为 Int?，其值为 2
 
 */

//: ## 关联类型
/*:
 关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。可以通过 associatedtype 关键字来指定关联类型。
 
 示例：
 
     protocol Container {
         associatedtype Item
         mutating func append(_ item: Item)
         var count: Int { get }
         subscript(i: Int) -> Item { get }
     }
 
 实现协议：
 
     struct IntStack: Container {
         // IntStack 的原始实现部分
         var items = [Int]()
         mutating func push(_ item: Int) {
             items.append(item)
         }
         mutating func pop() -> Int {
             return items.removeLast()
         }
         // Container 协议的实现部分
         typealias Item = Int
         mutating func append(_ item: Int) {
             self.push(item)
         }
         var count: Int {
             return items.count
         }
         subscript(i: Int) -> Int {
             return items[i]
         }
     }
 
 也可以定义泛型类型实现泛型协议：
 
     struct Stack<Element>: Container {
         // Stack<Element> 的原始实现部分
         var items = [Element]()
         mutating func push(_ item: Element) {
             items.append(item)
         }
         mutating func pop() -> Element {
             return items.removeLast()
         }
         // Container 协议的实现部分
         mutating func append(_ item: Element) {
             self.push(item)
         }
         var count: Int {
             return items.count
         }
         subscript(i: Int) -> Element {
             return items[i]
         }
     }
 
 扩展已有类型实现泛型协议：
 
     extension Array: Container {}
 
 */

//: ## 关联类型约束
/*:
 可以给协议里的关联类型添加类型注释，让遵守协议的类型必须遵循这个约束条件：
 
     protocol Container {
         associatedtype Item: Equatable
         mutating func append(_ item: Item)
         var count: Int { get }
         subscript(i: Int) -> Item { get }
     }
 
 ### 关联类型约束里使用协议
 协议可以作为它自身的定义出现：
 
     protocol SuffixableContainer: Container {
         associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
         func suffix(_ size: Int) -> Suffix
     }
 
     extension Stack: SuffixableContainer {
         func suffix(_ size: Int) -> Stack {
             var result = Stack()
             for index in (count-size)..<count {
                 result.append(self[index])
             }
             return result
         }
         // Inferred that Suffix is Stack.
     }
     var stackOfInts = Stack<Int>()
     stackOfInts.append(10)
     stackOfInts.append(20)
     stackOfInts.append(30)
     let suffix = stackOfInts.suffix(2)
     // suffix contains 20 and 30
 
     extension IntStack: SuffixableContainer {
         func suffix(_ size: Int) -> Stack<Int> {
             var result = Stack<Int>()
             for index in (count-size)..<count {
                 result.append(self[index])
             }
             return result
         }
         // Inferred that Suffix is Stack<Int>.
     }
 
 */

//: ## 泛型 Where 语句
/*:
 类型约束能够为泛型函数，下标，类型的类型参数定义一些强制要求。关联类型定义约束可以在参数列表中通过 where 子句为关联类型定义约束。通过 where 子句要求一个关联类型遵从某个特定的协议，以及某个特定的类型参数和关联类型必须类型相同。通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的相等关系。可以在函数体或者类型的大括号之前添加 where 子句：
 
     func allItemsMatch<C1: Container, C2: Container>
     (_ someContainer: C1, _ anotherContainer: C2) -> Bool
     where C1.Item == C2.Item, C1.Item: Equatable {
 
         // 检查两个容器含有相同数量的元素
         if someContainer.count != anotherContainer.count {
             return false
         }
 
         // 检查每一对元素是否相等
         for i in 0..<someContainer.count {
             if someContainer[i] != anotherContainer[i] {
                 return false
             }
         }
 
         // 所有元素都匹配，返回 true
         return true
     }
 
     var stackOfStrings = Stack<String>()
     stackOfStrings.push("uno")
     stackOfStrings.push("dos")
     stackOfStrings.push("tres")
 
     var arrayOfStrings = ["uno", "dos", "tres"]
 
     if allItemsMatch(stackOfStrings, arrayOfStrings) {
         print("All items match.")
     } else {
         print("Not all items match.")
     }
     // 打印 “All items match.”
 */

//: ## 扩展中的 Where 语句
/*:
 可以使用泛型 where 子句作为扩展的一部分：
 
     extension Stack where Element: Equatable {
         func isTop(_ item: Element) -> Bool {
             guard let topItem = items.last else {
                 return false
             }
             return topItem == item
         }
     }
 
     if stackOfStrings.isTop("tres") {
         print("Top element is tres.")
     } else {
         print("Top element is something else.")
     }
     // 打印 "Top element is tres."
 
 可以使用泛型 where 子句去扩展一个协议：
 
     extension Container where Item: Equatable {
         func startsWith(_ item: Item) -> Bool {
             return count >= 1 && self[0] == item
         }
     }
 
     if [9, 9, 9].startsWith(42) {
         print("Starts with 42.")
     } else {
         print("Starts with something else.")
     }
     // 打印 "Starts with something else."
 */

//: ## 关联类型的 Where 语句
/*:
 可以在关联类型后面加上具有泛型 where 的字句：
 
     protocol Container {
         associatedtype Item
         mutating func append(_ item: Item)
         var count: Int { get }
         subscript(i: Int) -> Item { get }
 
         associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
         func makeIterator() -> Iterator
     }
 
 一个协议继承另一个协议，通过在协议声明的时候，包含泛型 where 子句，来添加了一个约束到被继承协议的关联类型：
 
     protocol ComparableContainer: Container where Item: Comparable { }
 
 */

//: ## 泛型下标
/*:
 下标可以是泛型的，他们能够包含泛型 where 子句。可以把占位符类型的名称写在 subscript 后面的尖括号里，在下标代码体开始的标志的花括号之前写下泛型 where 子句。例如：
 
     extension Container {
         subscript<Indices: Sequence>(indices: Indices) -> [Item]
         where Indices.Iterator.Element == Int {
             var result = [Item]()
             for index in indices {
                 result.append(self[index])
             }
             return result
         }
     }
 
 */
//: [下一页](@next)
