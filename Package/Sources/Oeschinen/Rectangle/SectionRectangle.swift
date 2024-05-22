//
//  File.swift
//  
//
//  Created by stat on 5/22/24.
//

import Foundation
import UIKit

struct SectionRectangle: Rectangle {
    
    var style: Style = Style(
        title: TextStyle(font: .systemFont(ofSize: 14, weight: .bold))
    )
    
    var content: Content
    
    var container: CGRect {
        return Builder.effectiveSectionContainer
    }
    
    var contentSize: CGSize {
        var totalHeight = titleAttStr.height(in: container.width)
        for rectangle in bodyRectangles {
            totalHeight += rectangle.contentSize.height
        }
        return CGSize(width: container.width, height: totalHeight)
    }
    
    init(content: Content) {
        self.content = content
        self.bodyRectangles = content.children.map { BodyRectangle(content: $0) }
    }
    
    let bodyRectangles: [Rectangle]
    
    func render(in context: UIGraphicsPDFRendererContext) {
        if container.height < titleAttStr.height(in: container.width) {
            Builder.beginNewPage(in: context)
        }
        titleAttStr.draw(in: container)
        
        let h = titleAttStr.height(in: container.width)
        
        Builder.removeSectionContainerSpace(h, context: context)
        
        bodyRectangles.forEach { r in
            r.render(in: context)
        }
    }
}

