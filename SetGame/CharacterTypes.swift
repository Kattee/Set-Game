//
//  CharacterTypes.swift
//  SetGame
//
//

import UIKit

enum SymbolType: Int, CaseIterable {
    
    case circle = 0
    case triangle = 1
    case square = 2
    
    var value: String {
        switch self {
        case .circle:
            return "●"
        case .triangle:
            return "▲"
        case .square:
            return "■"
        }
    }
    
}

enum ColorType: Int, CaseIterable {
    
    case red = 0
    case yellow = 1
    case blue = 2
    
    var value: UIColor {
        switch self {
        case .red:
            return .red
        case .yellow:
            return .yellow
        case .blue:
            return .blue
        }
    }
    
}

enum NumberType: Int, CaseIterable {
    
    case one = 0
    case two = 1
    case three = 2
    
    var value: Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        }
    }
    
}

enum ShadeType: Int, CaseIterable {
    
    case solid = 0
    case striped = 1
    case open = 2
    
    var value: String {
        switch self {
        case .solid:
            return "solid"
        case .striped:
            return "striped"
        case .open:
            return "open"
        }
    }
    
}

