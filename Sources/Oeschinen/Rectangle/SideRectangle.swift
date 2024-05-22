//
//  File.swift
//  
//
//  Created by stat on 5/22/24.
//

import Foundation
import UIKit

struct SideRectangle: Rectangle {
    
    var style = Style(
        title: TextStyle(
            font: .systemFont(ofSize: 14, weight: .bold),
            alignment: .center
        ),
        description: TextStyle(
            font: .systemFont(ofSize: 11, weight: .regular),
            lineSpacing: 4
        ),
        childrenTitle: TextStyle(
            font: .systemFont(ofSize: 11, weight: .medium),
            minimumLineHeight: 22,
            alignment: .center,
            baselineOffset: 2
        ),
        childrenDescription: TextStyle(
            font: .systemFont(ofSize: 11, weight: .regular),
            alignment: .center
        )
    )
    
    var content: Content
    
    var container: CGRect
    
    var contentSize: CGSize {
        return CGSize(
            width: container.width,
            height: titleAttStr.height(in: container.width)
            + titleBottomPadding
            + subtitleAttStr.height(in: container.width)
            + descriptionAttStr.height(in: container.width)
            + childrenTitleAttStr.height(in: container.width)
            + childrenDescriptionAttStr.height(in: container.width)
            + Constant.pagePadding
            + Constant.separatorWidth
        )
    }
    
    func render(in context: UIGraphicsPDFRendererContext) {
        
        var effectiveContainer = container
        
        titleAttStr.draw(in: effectiveContainer)
        effectiveContainer.origin.y += titleAttStr.height(in: container.width) + titleBottomPadding
        
        if let subtitleAttStr {
            subtitleAttStr.draw(in: effectiveContainer)
            effectiveContainer.origin.y += subtitleAttStr.height(in: container.width)
        }
        
        if let descriptionAttStr {
            descriptionAttStr.draw(in: effectiveContainer)
            effectiveContainer.origin.y += descriptionAttStr.height(in: container.width)
        }
        
        zip(childrenTitleAttStr, childrenDescriptionAttStr).forEach { title, description in
            title.draw(in: effectiveContainer)
            effectiveContainer.origin.y += title.height(in: container.width)
            
            description?.draw(in: effectiveContainer)
            effectiveContainer.origin.y += description.height(in: container.width)
        }
        
        effectiveContainer.origin.y += Constant.pagePadding
        
        context.cgContext.drawLine(
            from: CGPoint(x: effectiveContainer.minX, y: effectiveContainer.minY),
            to: CGPoint(x: effectiveContainer.maxX, y: effectiveContainer.minY)
        )
        
        effectiveContainer.origin.y += Constant.separatorWidth
    }
}

extension SideRectangle {
    
    private var titleBottomPadding: CGFloat {
        return 16
    }
    
    private var childrenSpacing: CGFloat {
        return 8
    }
}

