//
//  File.swift
//  
//
//  Created by stat on 5/22/24.
//

import UIKit

typealias Attributes = [NSAttributedString.Key: Any]

struct Style {
    
    var title: TextStyle?
    
    var subtitle: TextStyle?
    
    var description: TextStyle?
    
    var childrenTitle: TextStyle?
    
    var childrenSubtitle: TextStyle?
    
    var childrenDescription: TextStyle?
}

struct TextStyle {
    
    var font: UIFont = .systemFont(ofSize: 10, weight: .regular)
    
    var minimumLineHeight: CGFloat?
    
    var alignment: NSTextAlignment?
    
    var lineSpacing: CGFloat = 2
    
    var baselineOffset: CGFloat = 0
    
    var color: UIColor = .black
    
    var attributes: Attributes {
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpacing
        
        if let minimumLineHeight {
            paragraphStyle.minimumLineHeight = minimumLineHeight
        }
        
        if let alignment {
            paragraphStyle.alignment = alignment
        }
        
        return [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .baselineOffset: baselineOffset,
            .foregroundColor: color
        ]
    }
}
