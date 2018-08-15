//
// Collection-Types.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation

//: # 集合类型
/*:
 Swift 语言提供 Arrays、Sets 和 Dictionaries 三种基本的集合类型用来存储集合数据。数组（Arrays）是有序数据的集。集合（Sets）是无序无重复数据的集。字典（Dictionaries）是无序的键值对的集。
 
 Swift 语言中的 Arrays、Sets 和 Dictionaries 中存储的数据值类型必须明确，不能把错误的数据类型插入其中。
 
 - Note:
 Swift 的 Arrays、Sets 和 Dictionaries 类型均是以泛型实现的。
 
 ## 集合可变性
 创建一个变量的 Arrays、Sets 或 Dictionaries ，这个集合就是可变的。创建一个常量 Arrays、Sets 或 Dictionaries ，那么它就是不可变的，大小和内容都不能被改变。
 */

//: ## 数组
/*:
 数组使用有序列表存储同一类型的多个值。相同的值可以多次出现在一个数组的不同位置中。 Swift 中的 Array 类型可以和 Foundation 中的 NSArray 相互桥接使用。
 */
//: ### 数组的语法
/*:
 Swift 数组声明方式为 Array<Element> ，其中 Element 是这个数组中唯一允许存在的数据类型。同时，也可以使用像 [Element] 这样的简单语法。
 */
//: ### 创建空数组
/*:
 创建空数组有两种方式，一种是直接调用初始换函数，另一种是使用空数组字面量：
 
     var someInts = [Int]()
     print("someInts is of type [Int] with \(someInts.count) items.")
     // 打印 "someInts is of type [Int] with 0 items."
 
     someInts.append(3)
     // someInts 现在包含一个 Int 值
     someInts = []
     // someInts 现在是空数组，但是仍然是 [Int] 类型的。
 
 */
//: ### 创建带默认值的数组
/*:
 Swift 中的 Array 类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。我们可以把准备加入新数组的数据数量（count）和适当类型的初始值（repeating）传入数组构造函数：
 
     var threeDoubles = Array(repeating: 0.0, count: 3)
     // threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]
 
 */
//: ### 使用数组字面量
/*:
 可以使用数组字面量来进行数组构造，这是一种用一个或者多个数值构造数组的简单方法。数组字面量是一系列由逗号分割并由方括号包含的数值：
 
     [value 1, value 2, value 3]
 
     var shoppingList: [String] = ["Eggs", "Milk"]
     // shoppingList 已经被构造并且拥有两个初始项。
 
 可以省略类型声明， Swift 会自动推断类型：
 
     var shoppingList = ["Eggs", "Milk"]
 
 */
//: ## 集合
/*:
 集合（Set）用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。 Swift 中的 Set 类型可以和 Foundation 中的 NSSet 相互桥接使用。
 */
//: ### 集合类型的哈希值
/*:
 一个类型为了存储在集合中，该类型必须是可哈希化的--也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是 Int 类型的，相等的对象哈希值必须相同，比如 a==b,因此必须 a.hashValue == b.hashValue。
 
 Swift 的所有基本类型（比如 String,Int,Double 和 Bool）默认都是可哈希化的，可以作为集合的值的类型或者字典的键的类型。没有关联值的枚举成员值默认也是可哈希化的。
 
 可以使用自定义的类型作为集合的值的类型或者是字典的键的类型，但你需要使你的自定义类型符合 Swift 标准库中的 Hashable 协议。
 */
//: ### 集合类型语法
/*:
 Swift 中的 Set 类型声明为 Set<Element>，这里的 Element 表示 Set 中允许存储的类型。
 */
//: ### 创建和构造一个空的集合
/*:
 可以通过构造器语法创建一个特定类型的空集合：
 
     var letters = Set<Character>()
     print("letters is of type Set<Character> with \(letters.count) items.")
     // 打印 "letters is of type Set<Character> with 0 items."
 
 可以通过一个空的数组字面量创建一个空的 Set：
 
     letters.insert("a")
     // letters 现在含有1个 Character 类型的值
     letters = []
     // letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型
 
 */
//: ### 用数组字面量创建集合
/*:
 可以使用数组字面量来构造集合：
 
     var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
     // favoriteGenres 被构造成含有三个初始值的集合
 
 Set 类型不能从数组字面量中被单独推断出来，因此 Set 类型必须显式声明：
 
     var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
 
 */
//: ### 集合操作
/*:
 可以高效地完成 Set 的一些基本操作，比如把两个集合组合到一起，判断两个集合共有元素，或者判断两个集合是否全包含，部分包含或者不相交。
 */
//: ### 基本集合操作
/*:
 - 使用 intersection(_:) 方法根据两个集合中都包含的值创建的一个新的集合。
 - 使用 symmetricDifference(_:) 方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
 - 使用 union(_:) 方法根据两个集合的值创建一个新的集合。
 - 使用 subtracting(_:) 方法根据不在该集合中的值创建一个新的集合。
 
 示例：
 
     let oddDigits: Set = [1, 3, 5, 7, 9]
     let evenDigits: Set = [0, 2, 4, 6, 8]
     let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
 
     oddDigits.union(evenDigits).sorted()
     // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     oddDigits. intersection(evenDigits).sorted()
     // []
     oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
     // [1, 9]
     oddDigits. symmetricDifference(singleDigitPrimeNumbers).sorted()
     // [1, 2, 9]
 
 */
//: ### 集合成员关系和相等
/*:
 - 使用“是否相等”运算符（==）来判断两个集合是否包含全部相同的值。
 - 使用 isSubset(of:) 方法来判断一个集合中的值是否也被包含在另外一个集合中。
 - 使用 isSuperset(of:) 方法来判断一个集合中包含另一个集合中所有的值。
 - 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
 - 使用 isDisjoint(with:) 方法来判断两个集合是否不含有相同的值（是否没有交集）。
 
 示例：
 
     let houseAnimals: Set = ["🐶", "🐱"]
     let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
     let cityAnimals: Set = ["🐦", "🐭"]
 
     houseAnimals.isSubset(of: farmAnimals)
     // true
     farmAnimals.isSuperset(of: houseAnimals)
     // true
     farmAnimals.isDisjoint(with: cityAnimals)
     // true
 
 */
//: ## 字典
/*:
 字典是一种存储多个相同类型的值的容器。每个值（value）都关联唯一的键（key），键作为字典中的这个值数据的标识符。 Swift 中的 Dictionary 类型可以和 Foundation 中的 NSDictionary 相互桥接使用。
 */
//: ### 字典类型声明
/*:
 Swift 的字典使用 Dictionary<Key, Value> 定义，其中 Key 是字典中键的数据类型，Value 是字典中对应于这些键所存储值的数据类型，用 [Key: Value] 简化声明。字典的 Key 类型必须遵循 Hashable 协议。
 */
//: ### 创建空字典
/*:
 可以像数组一样使用构造语法创建一个拥有确定类型的空字典：
 
     var namesOfIntegers = [Int: String]()
     // namesOfIntegers 是一个空的 [Int: String] 字典
 
     namesOfIntegers[16] = "sixteen"
     // namesOfIntegers 现在包含一个键值对
     namesOfIntegers = [:]
     // namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
 
 */
//: ### 用字面量创建字典
/*:
 可以使用字典字面量来构造字典，字典字面量是一种将一个或多个键值对写作 Dictionary 集合简写方式：
 
     [key 1: value 1, key 2: value 2, key 3: value 3]
 
 如：
 
     var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
 
 可以使用类型推断：
 
     var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
 
 */
//: ### 访问和修改集合类型
/*:
 可以通过集合类型的方法和属性来访问和修改集合类型，或者使用下标语法。获取数量：
 
     print("The shopping list contains \(shoppingList.count) items.")
     // 输出 "The shopping list contains 2 items."（这个数组有2个项）
 
 使用布尔属性 isEmpty 检测数组是否为空；如果只需要判断一个数字是否为空，尽量使用 isEmpty 来判断，使用 count 判断会遍历数组， isEmpty 不会发生遍历，而是判断数组的首尾指针是否相等，效率更快：
 
     if shoppingList.isEmpty {
         print("The shopping list is empty.")
     } else {
         print("The shopping list is not empty.")
     }
     // 打印 "The shopping list is not empty."（shoppinglist 不是空的）
 
 使用 append(_:) 方法添加数据：
 
     shoppingList.append("Flour")
     // shoppingList 现在有3个数据项，有人在摊煎饼
 
 使用运算符添加数据：
 
     shoppingList += ["Baking Powder"]
     // shoppingList 现在有四项了
     shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
     // shoppingList 现在有七项了
 
 使用下标语法来获取数组中的数据：
 
     var firstItem = shoppingList[0]
     // 第一项是 "Eggs"
 
 使用下标来改变某个已有索引值对应的数据：
 
     shoppingList[0] = "Six eggs"
     // 其中的第一项现在是 "Six eggs" 而不是 "Eggs"
 
     shoppingList[4...6] = ["Bananas", "Apples"]
     // shoppingList 现在有6项
 
 调用数组的 insert(_:at:) 方法来插入数据：
 
     shoppingList.insert("Maple Syrup", at: 0)
     // shoppingList 现在有7项
     // "Maple Syrup" 现在是这个列表中的第一项
 
 使用 remove(at:) 方法来移除数据：
 
     let mapleSyrup = shoppingList.remove(at: 0)
     // 索引值为0的数据项被移除
     // shoppingList 现在只有6项，而且不包括 Maple Syrup
     // mapleSyrup 常量的值等于被移除数据项的值 "Maple Syrup"
 
     let apples = shoppingList.removeLast()
     // 数组的最后一项被移除了
     // shoppingList 现在只有5项，不包括 Apples
     // apples 常量的值现在等于 "Apples" 字符串
 
 */
//: ## 遍历集合类型
/*:
 可以使用 for-in 循环来遍历：
 
 
 数组和 Set ：
 
     for item in shoppingList {
         print(item)
     }
     // Six eggs
     // Milk
     // Flour
     // Baking Powder
     // Bananas
 
 字典：
 
     for (airportCode, airportName) in airports {
         print("\(airportCode): \(airportName)")
     }
     // YYZ: Toronto Pearson
     // LHR: London Heathrow
 
 使用 enumerated() 方法来获取数组的索引和值：
 
     for (index, value) in shoppingList. enumerated() {
         print("Item \(String(index + 1)): \(value)")
     }
     // Item 1: Six eggs
     // Item 2: Milk
     // Item 3: Flour
     // Item 4: Baking Powder
     // Item 5: Bananas
 
 */
//: ## 内建方法
/*:
 所有集合类型都实现了 Sequence 协议， Sequence 协议作为标准库类型，定义了一系列内建的函数和属性，最常见的就是一系列的集合操作，而且多数都是函数式编程的思想在里边， [Swquence](https://developer.apple.com/documentation/swift/sequence) 定义。
 */
//: [下一页](@next)
let arr = [1, 2]
for item in arr.reversed() {
    
}
