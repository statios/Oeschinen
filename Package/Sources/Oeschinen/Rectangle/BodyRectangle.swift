//
//  File.swift
//  
//
//  Created by stat on 5/22/24.
//

import Foundation
import UIKit

struct BodyRectangle: Rectangle {
    
    var style: Style {
        Style(
            title: TextStyle(
                font: .systemFont(ofSize: 13, weight: .semibold),
                minimumLineHeight: 40
            ),
            subtitle: TextStyle(
                font: .systemFont(ofSize: 12, weight: .medium),
                minimumLineHeight: 40
            ),
            description: TextStyle(
                font: .systemFont(ofSize: 12, weight: .medium),
                minimumLineHeight: 17
            ),
            childrenTitle: TextStyle(
                font: .systemFont(ofSize: 11, weight: .medium),
                minimumLineHeight: 40,
                baselineOffset: 6
            ),
            childrenDescription: TextStyle(
                font: .systemFont(ofSize: 11, weight: .regular),
                lineSpacing: 4
            )
        )
    }
    
    var content: Content
    
    var container: CGRect {
        Builder.effectiveSectionContainer
    }
    
    var contentSize: CGSize {
        return CGSize(
            width: container.width,
            height: titleAttStr.height(in: container.width)
            + descriptionAttStr.height(in: container.width)
            + childrenTitleAttStr.height(in: container.width)
            + childrenDescriptionAttStr.height(in: container.width)
        )
    }
    
    func render(in context: UIGraphicsPDFRendererContext) {
        
        let headlineHeight = titleAttStr.height(in: container.width)
        + descriptionAttStr.height(in: container.width)
        
        if headlineHeight > container.height {
            Builder.beginNewPage(in: context)
        }
        
        titleAttStr.draw(in: container)
        
        if let subtitleAttStr {
            subtitleAttStr.draw(
                in: CGRect(
                    x: container.maxX - subtitleAttStr.size().width,
                    y: container.origin.y,
                    width: subtitleAttStr.size().width,
                    height: subtitleAttStr.size().height
                )
            )
        }
        
        Builder.removeSectionContainerSpace(titleAttStr.height(in: container.width), context: context)
        
        if let descriptionAttStr {
            descriptionAttStr.draw(in: container)
            Builder.removeSectionContainerSpace(descriptionAttStr.height(in: container.width), context: context)
        }
        
        zip(childrenTitleAttStr, childrenDescriptionAttStr).forEach { title, description in
            
            let titleHeight = title.height(in: container.width)
            let descriptionHeight = description.height(in: container.width)
            
            if titleHeight + descriptionHeight > Builder.effectiveSectionContainer.height {
                Builder.beginNewPage(in: context)
            }
            
            title.draw(in: container)
            Builder.removeSectionContainerSpace(titleHeight, context: context)
            
            description?.draw(in: container)
            Builder.removeSectionContainerSpace(descriptionHeight, context: context)
        }
    }
}

