//
//  File.swift
//  
//
//  Created by stat on 5/22/24.
//

import Foundation
import UIKit

protocol Rectangle {
    
    var style: Style { get }
    
    var content: Content { get }
    
    var container: CGRect { get }
    
    var contentSize: CGSize { get }
    
    func render(in context: UIGraphicsPDFRendererContext)
}

extension Rectangle {
    
    var titleAttStr: NSAttributedString {
        return NSAttributedString(string: content.title, attributes: style.title?.attributes)
    }
    
    var subtitleAttStr: NSAttributedString? {
        guard let subtitle = content.subtitle else { return nil }
        return NSAttributedString(string: subtitle, attributes: style.subtitle?.attributes)
    }
    
    var descriptionAttStr: NSAttributedString? {
        guard let description = content.description else { return nil }
        return NSAttributedString(string: description, attributes: style.description?.attributes)
    }
    
    var childrenTitleAttStr: [NSAttributedString] {
        return content.children.map { NSAttributedString(string: $0.title, attributes: style.childrenTitle?.attributes) }
    }
    
    var childrenSubtitleAttStr: [NSAttributedString?] {
        return content.children.map { NSAttributedString(string: $0.subtitle, attributes: style.childrenSubtitle?.attributes) }
    }
    
    var childrenDescriptionAttStr: [NSAttributedString?] {
        return content.children.map { NSAttributedString(string: $0.description, attributes: style.childrenDescription?.attributes) }
    }
}

typealias ChildAttributedStrings = (title: NSAttributedString, subtitle: NSAttributedString?, description: NSAttributedString?)

extension NSAttributedString {
    convenience init?(string: String?, attributes: Attributes?) {
        guard let string else { return nil }
        self.init(string: string, attributes: attributes)
    }
}

extension CGContext {
    func drawLine(from: CGPoint, to: CGPoint) {
        setLineWidth(Constant.separatorWidth)
        move(to: from)
        addLine(to: to)
        strokePath()
    }
}

