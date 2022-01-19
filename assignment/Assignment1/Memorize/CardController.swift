//
//  CardController.swift
//  Memorize
//
//  Created by Nick Yang on 2022/1/19.
//

import Foundation

enum ThemeType: CustomStringConvertible {
    case vehicle, animal, food
    
    var emojis: [String] {
        switch self {
        case .vehicle: return ["🚗","🚕","🚙","🚌","🏎","🚑","🚓","🚒","🚐","🛻","🚛","✈️","🛰","🚀","🛸","🚁"]
        case .animal:  return ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼"]
        case .food:    return ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍","🥥"]
        }
    }
    
    var description: String {
        switch self {
        case .vehicle: return "vehicle"
        case .animal:  return "animal"
        case .food:    return "food"
        }
    }
}

class CardController {
    static let shared = CardController()
    
    func shuffle(by type: ThemeType) -> [String] {
        var emojis: [String] = []
        var i: Int = Int.random(in: 0...7)
        while emojis.count < type.emojis.count {
            emojis.append(type.emojis[i])
            i += 1
            if i == type.emojis.count {
                i = 0 // return to index 0
            }
        }
        return emojis
    }
    
}
