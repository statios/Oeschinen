//
//  File.swift
//  
//
//  Created by stat on 5/22/24.
//

import Foundation

public struct Content {
    
    public var title: String
    
    public var subtitle: String?
    
    // paragraph
    public var description: String?
    
    public var children: [Content] = []
    
    public init(title: String, subtitle: String? = nil, description: String? = nil, children: [Content] = []) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.children = children
    }
}
