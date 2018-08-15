//
// Nested-Types.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 嵌套类型
/*:
 Swift 允许定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类和结构体。要在一个类型中嵌套另一个类型，将嵌套类型的定义写在其外部类型的 {} 内即可，而且可以多级嵌套。
 */
//: ## 实例
/*:
     struct BlackjackCard {
 
         // 嵌套的 Suit 枚举
         enum Suit: Character {
             case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
         }
 
         // 嵌套的 Rank 枚举
         enum Rank: Int {
             case two = 2, three, four, five, six, seven, eight, nine, ten
             case jack, queen, king, ace
             struct Values {
                 let first: Int, second: Int?
             }
             var values: Values {
                 switch self {
                 case .ace:
                     return Values(first: 1, second: 11)
                 case .jack, .queen, .king:
                     return Values(first: 10, second: nil)
                 default:
                     return Values(first: self.rawValue, second: nil)
                 }
             }
         }
 
         // BlackjackCard 的属性和方法
         let rank: Rank, suit: Suit
         var description: String {
             var output = "suit is \(suit.rawValue),"
             output += " value is \(rank.values.first)"
             if let second = rank.values.second {
                 output += " or \(second)"
             }
             return output
         }
     }
 
     let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
     print("theAceOfSpades: \(theAceOfSpades.description)")
     // 打印 “theAceOfSpades: suit is ♠, value is 1 or 11”
 */
struct BlackjackCard {
    
    // 嵌套的 Suit 枚举
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    // 嵌套的 Rank 枚举
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
//: ## 引用嵌套类型
/*:
 在外部引用嵌套类型时，在嵌套类型的类型名前加上其外部类型的类型名作为前缀：
 
     let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
     // 红心符号为 “♡”
 
 */
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
//: [下一页](@next)
