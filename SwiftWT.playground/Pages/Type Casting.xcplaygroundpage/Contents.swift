//
// Type-Casting.xcplaygroundpage
// SwiftWT
//
// Created by devedbox.
//
//: [上一页](@previous)
import Foundation
//: # 类型转换
/*:
 类型检查可以判断实例的类型，使用 is 操作符实现；类型转换使用 as 操作符实现。使用 is 类型检查还可以用来检查一个类型是否实现了某个协议。
 
     class MediaItem {
         var name: String
         init(name: String) {
             self.name = name
         }
     }
     
     class Movie: MediaItem {
         var director: String
         init(name: String, director: String) {
             self.director = director
             super.init(name: name)
         }
     }
     
     class Song: MediaItem {
         var artist: String
         init(name: String, artist: String) {
             self.artist = artist
             super.init(name: name)
         }
     }
     
     let library = [
         Movie(name: "Casablanca", director: "Michael Curtiz"),
         Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
         Movie(name: "Citizen Kane", director: "Orson Welles"),
         Song(name: "The One And Only", artist: "Chesney Hawkes"),
         Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
     ]
 */
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
//: ## 类型检查
/*:
 用类型检查操作符（is）来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false。
 
     var movieCount = 0
     var songCount = 0
 
     for item in library {
         if item is Movie {
             movieCount += 1
         } else if item is Song {
             songCount += 1
         }
     }
 
     print("Media library contains \(movieCount) movies and \(songCount) songs")
     // 打印 “Media library contains 2 movies and 3 songs”
 
 */
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
//: ## 向下转型
/*:
 某类型的一个常量或变量可能在实现上属于一个子类。这种情况可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）。向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式 as? 返回一个试图向下转成的类型的可选值。强制形式 as! 把试图向下转型和强制解包转换结果结合为一个操作，当转换失败是会触发运行时错误。
 
     for item in library {
         if let movie = item as? Movie {
             print("Movie: '\(movie.name)', dir. \(movie.director)")
         } else if let song = item as? Song {
             print("Song: '\(song.name)', by \(song.artist)")
         }
     }
 
     // Movie: 'Casablanca', dir. Michael Curtiz
     // Song: 'Blue Suede Shoes', by Elvis Presley
     // Movie: 'Citizen Kane', dir. Orson Welles
     // Song: 'The One And Only', by Chesney Hawkes
     // Song: 'Never Gonna Give You Up', by Rick Astley
 
 */
for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}
//: ## Any 和 AnyObject
/*:
 Swift 为不确定类型提供了两种特殊的类型别名：
 - Any 可以表示任何类型，包括函数类型
 - AnyObject 可以表示任何类类型的实例
 
     var things = [Any]()
 
     things.append(0)
     things.append(0.0)
     things.append(42)
     things.append(3.14159)
     things.append("hello")
     things.append((3.0, 5.0))
     things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
     things.append({ (name: String) -> String in "Hello, \(name)" })
 
 在 switch 表达式的 case 中使用 is 和 as 操作符判断类型：
 
     for thing in things {
         switch thing {
         case 0 as Int:
             print("zero as an Int")
         case 0 as Double:
             print("zero as a Double")
         case let someInt as Int:
             print("an integer value of \(someInt)")
         case let someDouble as Double where someDouble > 0:
             print("a positive double value of \(someDouble)")
         case is Double:
             print("some other double value that I don't want to print")
         case let someString as String:
             print("a string value of \"\(someString)\"")
         case let (x, y) as (Double, Double):
             print("an (x, y) point at \(x), \(y)")
         case let movie as Movie:
             print("a movie called '\(movie.name)', dir. \(movie.director)")
         case let stringConverter as (String) -> String:
             print(stringConverter("Michael"))
         default:
             print("something else")
         }
     }
 
     // zero as an Int
     // zero as a Double
     // an integer value of 42
     // a positive double value of 3.14159
     // a string value of "hello"
     // an (x, y) point at 3.0, 5.0
     // a movie called 'Ghostbusters', dir. Ivan Reitman
     // Hello, Michael
 
 */
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
//: [下一页](@next)
