//
//  File.swift
//  
//
//  Created by stat on 5/22/24.
//

import Foundation
import UIKit

struct HeaderRectangle: Rectangle {
    
    var style: Style {
        Style(
            title: TextStyle(
                font: .systemFont(ofSize: 22, weight: .bold)
            ),
            subtitle: TextStyle(
                font: .systemFont(ofSize: 13, weight: .semibold)
            ),
            description: TextStyle(
                font: .systemFont(ofSize: 11, weight: .regular)
            ),
            childrenTitle: TextStyle(
                font: .systemFont(ofSize: 10, weight: .semibold)
            ),
            childrenDescription:  TextStyle(
                font: .systemFont(ofSize: 10, weight: .regular)
            )
        )
    }
    
    var content: Content
    
    var container: CGRect
    
    var contentSize: CGSize {
        return CGSize(
            width: container.width,
            height: titleAttStr.height(in: container.width)
            + subtitleAttStr.height(in: container.width)
            + descriptionAttStr.height(in: container.width)
            + areaSpacing
            + childrenDescriptionAttStr.height(in: childrenDescriptionWidth, spacing: childrenSpacing)
        )
    }
    
    func render(in context: UIGraphicsPDFRendererContext) {
        
        var effectiveContainer = container
        
        titleAttStr.draw(in: effectiveContainer)
        effectiveContainer.origin.y += titleAttStr.height(in: container.width)
        
        if let subtitleAttStr {
            subtitleAttStr.draw(in: effectiveContainer)
            effectiveContainer.origin.y += subtitleAttStr.height(in: container.width)
        }
        
        if let descriptionAttStr {
            descriptionAttStr.draw(in: effectiveContainer)
            effectiveContainer.origin.y += descriptionAttStr.height(in: container.width)
        }
        
        effectiveContainer.origin.y += areaSpacing
        
        var effectiveChildrenTitleContainer = effectiveContainer
        effectiveChildrenTitleContainer.origin.x += childrenIndent
        effectiveChildrenTitleContainer.size.width -= childrenIndent
        
        var effectiveChildrenDescriptionContainer = effectiveChildrenTitleContainer
        effectiveChildrenDescriptionContainer.origin.x += childrenTitleWidth + childrenSpacingBetweenTitleDescription
        effectiveChildrenDescriptionContainer.size.width -= childrenTitleWidth + childrenSpacingBetweenTitleDescription
        
        zip(childrenTitleAttStr, childrenDescriptionAttStr).forEach { title, description in
            title.draw(in: effectiveChildrenTitleContainer)
            description?.draw(in: effectiveChildrenDescriptionContainer)
            
            let height = max(
                title.height(in: effectiveChildrenTitleContainer.width),
                description.height(in: effectiveChildrenDescriptionContainer.width)
            )
            
            effectiveChildrenTitleContainer.origin.y += height + childrenSpacing
            effectiveChildrenDescriptionContainer.origin.y += height + childrenSpacing
        }
    }
}

extension HeaderRectangle {
    
    private var areaSpacing: CGFloat {
        return 24
    }
    
    private var childrenIndent: CGFloat {
        return 104
    }
    
    private var childrenTitleWidth: CGFloat {
        return childrenTitleAttStr.reduce(0) { max($0, $1.size().width) }
    }
    
    private var childrenSpacing: CGFloat {
        return 6
    }
    
    private var childrenSpacingBetweenTitleDescription: CGFloat {
        return 16
    }
    
    private var childrenDescriptionWidth: CGFloat {
        return container.width - childrenIndent - childrenTitleWidth - childrenSpacingBetweenTitleDescription
    }
}

extension NSAttributedString {
    
    func height(in width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.height
    }
}

extension Optional where Wrapped == NSAttributedString {
    
    func height(in width: CGFloat) -> CGFloat {
        guard let attStr = self else { return .zero }
        return attStr.height(in: width)
    }
}

extension Array where Element == NSAttributedString {
    
    func height(in width: CGFloat, spacing: CGFloat = 0) -> CGFloat {
        return reduce(0) { $0 + $1.height(in: width) + spacing }
    }
}

extension Array where Element == Optional<NSAttributedString> {
    
    func height(in width: CGFloat, spacing: CGFloat = 0) -> CGFloat {
        return reduce(0) {
            $1 == nil
            ? $0 + $1.height(in: width)
            : $0 + $1.height(in: width) + spacing
        }
    }
}

