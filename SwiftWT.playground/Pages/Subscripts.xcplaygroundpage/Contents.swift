//
// Subscripts.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 下标
/* :
 下标可以定义在类、结构体和枚举中，是访问集合、列表或序列中元素的快捷方式。可以使用下标的索引，设置和获取值，而不需要再调用对应的存取方法。举例来说，用下标访问一个 Array 实例中的元素可以写作 someArray[index]，访问 Dictionary 实例中的元素可以写作 someDictionary[key]。
 
 一个类型可以定义多个下标，通过不同索引类型进行重载。下标不限于一维，你可以定义具有多个入参的下标满足自定义类型的需求。
 */

//: ## 下标语法
/*:
 与定义实例方法类似，定义下标使用 subscript 关键字，指定一个或多个输入参数和返回类型；与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类似计算型属性，Swift 中任意类型都可以定义下标：
 
     subscript(index: Int) -> Int {
         get {
             // 返回一个适当的 Int 类型的值
         }
 
         set(newValue) {
             // 执行适当的赋值操作
         }
     }
 
 readonly：
 
     subscript(index: Int) -> Int {
         // 返回一个适当的 Int 类型的值
     }
 
     struct TimesTable {
         let multiplier: Int
         subscript(index: Int) -> Int {
             return multiplier * index
         }
     }
     let threeTimesTable = TimesTable(multiplier: 3)
     print("six times three is \(threeTimesTable[6])")
     // 打印 "six times three is 18"
 
 */

//: ## 下标参数
/*:
 下标可以接受任意数量的入参，并且这些入参可以是任意类型。下标的返回值也可以是任意类型。下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。
 
 下标可以重载，一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标：
 
     struct Matrix {
         let rows: Int, columns: Int
         var grid: [Double]
         init(rows: Int, columns: Int) {
             self.rows = rows
             self.columns = columns
             grid = Array(repeating: 0.0, count: rows * columns)
         }
         func indexIsValid(row: Int, column: Int) -> Bool {
             return row >= 0 && row < rows && column >= 0 && column < columns
         }
         subscript(row: Int, column: Int) -> Double {
             get {
                 assert(indexIsValid(row: row, column: column), "Index out of range")
                 return grid[(row * columns) + column]
             }
             set {
                 assert(indexIsValid(row: row, column: column), "Index out of range")
                 grid[(row * columns) + column] = newValue
             }
         }
     }
 
     var matrix = Matrix(rows: 2, columns: 2)
     matrix[0, 1] = 1.5
     matrix[1, 0] = 3.2
 
     let someValue = matrix[2, 2]
     // 断言将会触发，因为 [2, 2] 已经超过了 matrix 的范围
 
 */
//: [下一页](@next)
