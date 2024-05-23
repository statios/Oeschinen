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
                font: .systemFont(ofSize: 13, weight: .semibold)
            ),
            subtitle: TextStyle(
                font: .systemFont(ofSize: 12, weight: .medium)
            ),
            description: TextStyle(
                font: .systemFont(ofSize: 12, weight: .medium)
            ),
            childrenTitle: TextStyle(
                font: .systemFont(ofSize: 11, weight: .medium)
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
        
        let titleHeight = titleAttStr.height(in: container.width)
        let descriptionHeight = descriptionAttStr.height(in: container.width)
        
        let headlineHeight = headerSpacing
        + titleHeight
        + spacingBetweenTitleDescription
        + descriptionHeight
        
        if headlineHeight > container.height {
            Builder.beginNewPage(in: context)
        } else {
            Builder.removeSectionContainerSpace(headerSpacing, context: context)
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
        
        Builder.removeSectionContainerSpace(titleHeight + spacingBetweenTitleDescription, context: context)
        
        if let descriptionAttStr {
            descriptionAttStr.draw(in: container)
            Builder.removeSectionContainerSpace(descriptionHeight, context: context)
        }
        
        zip(childrenTitleAttStr, childrenDescriptionAttStr).forEach { title, description in
            
            let titleHeight = title.height(in: container.width)
            let descriptionHeight = description.height(in: container.width)
            let spacingBetweenTitleDescription = descriptionHeight == .zero
            ? .zero
            : spacingBetweenChildren
            
            let contentHeight = childrenHeaderSpacing
            + titleHeight
            + spacingBetweenTitleDescription
            + descriptionHeight
            
            if contentHeight > Builder.effectiveSectionContainer.height {
                Builder.beginNewPage(in: context)
            } else {
                Builder.removeSectionContainerSpace(childrenHeaderSpacing, context: context)
            }
            
            title.draw(in: container)
            Builder.removeSectionContainerSpace(titleHeight + spacingBetweenTitleDescription, context: context)
            
            description?.draw(in: container)
            Builder.removeSectionContainerSpace(descriptionHeight, context: context)
        }
    }
}

extension BodyRectangle {
    
    var headerSpacing: CGFloat {
        return 24
    }
    
    var spacingBetweenTitleDescription: CGFloat {
        if content.description == nil {
            return .zero
        }
        return 2
    }
    
    var childrenHeaderSpacing: CGFloat {
        return 16
    }
    
    var spacingBetweenChildren: CGFloat {
        return 4
    }
}
