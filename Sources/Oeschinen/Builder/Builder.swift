//
//  File.swift
//  
//
//  Created by stat on 5/22/24.
//

import Foundation

import Foundation
import PDFKit

struct Constant {
    
    static let pageSize = CGSize(width: 8.5 * 72.0, height: 11.0 * 72.0)
    
    static let pagePadding = CGFloat(40)
    
    static var pageContentSize: CGSize {
        return CGSize(
            width: pageSize.width - pagePadding * 2,
            height: pageSize.height - pagePadding * 2
        )
    }
    
    static var sideWidth: CGFloat {
        return 240
    }
    
    static let separatorWidth: CGFloat = 1
    
    static let sectionSpacing = CGFloat(48)
    
    static let sideSpacing = CGFloat(40)
}

fileprivate extension TextStyle {
    
    static var footnote: TextStyle {
        TextStyle(
            font: .systemFont(ofSize: 8, weight: .regular),
            alignment: .right,
            color: .gray
        )
    }
}

public struct Builder {
    
    private static var remainingSides = [Content]()
    
    public static func createPDF(
        header: Content,
        sides: [Content],
        sections: [Content],
        footnote: String
    ) -> Data {
        
        let pdfMetaData = [
            kCGPDFContextCreator: "Oeschinen",
            kCGPDFContextAuthor: "Stat"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageRect = CGRect(x: .zero, y: .zero, width: Constant.pageSize.width, height: Constant.pageSize.height)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        remainingSides = sides

        let data = renderer.pdfData { (context) in
            
            context.beginPage()
            
            context.cgContext.drawLine(
                from: CGPoint(x: pageRect.minX+Constant.sideWidth, y: pageRect.minY),
                to: CGPoint(x: pageRect.minX+Constant.sideWidth, y: pageRect.maxY)
            )
            
            let headerContainer = CGRect(
                x: pageRect.origin.x + Constant.sideWidth + Constant.pagePadding,
                y: pageRect.origin.y + Constant.pagePadding,
                width: pageRect.width - Constant.sideWidth - Constant.pagePadding * 2,
                height: pageRect.height - Constant.pagePadding * 2
            )
            
            let headerRectangle = HeaderRectangle(content: header, container: headerContainer)
            headerRectangle.render(in: context)
            
            context.cgContext.drawLine(
                from: CGPoint(x: pageRect.minX, y: pageRect.origin.y + Constant.pagePadding * 2 + headerRectangle.contentSize.height),
                to: CGPoint(x: pageRect.maxX, y: pageRect.origin.y + Constant.pagePadding * 2 + headerRectangle.contentSize.height)
            )
            
            let bottomY = Constant.pagePadding * 3 + headerRectangle.contentSize.height
            
            if let image = UIImage(named: "img.JPG") {
                let height = ceil(Constant.pagePadding * 2 + headerRectangle.contentSize.height)
                let croppedImage = ImageBuilder.cropImage(
                    image: image,
                    size: CGSize(width: Constant.sideWidth, height: height)
                )
                croppedImage.draw(at: CGPoint(x: pageRect.minX, y: pageRect.minY))
            }
            
            effectiveSideContainer = CGRect(
                x: Constant.pagePadding,
                y: bottomY,
                width: Constant.sideWidth - Constant.pagePadding * 2,
                height: Constant.pageSize.height - headerRectangle.contentSize.height - Constant.pagePadding * 4
            )
            
            effectiveSectionContainer = CGRect(
                x: Constant.sideWidth + Constant.pagePadding,
                y: bottomY,
                width: pageRect.width - Constant.sideWidth - Constant.pagePadding * 2,
                height: Constant.pageSize.height - headerRectangle.contentSize.height - Constant.pagePadding * 4
            )
            
            renderSide(in: context)
            
            sections.forEach { section in
                let sectionRectangle = SectionRectangle(content: section)
                sectionRectangle.render(in: context)
                removeSectionContainerSpace(Constant.sectionSpacing, context: context)
            }
            
            let footnoteAttStr = NSAttributedString(string: footnote, attributes: TextStyle.footnote.attributes)
            footnoteAttStr.draw(
                in: CGRect(
                    x: Constant.pageSize.width - 8 - footnoteAttStr.size().width,
                    y: Constant.pageSize.height - 8 - footnoteAttStr.size().height,
                    width: footnoteAttStr.size().width,
                    height: footnoteAttStr.size().height
                )
            )
        }
        
        return data
    }
    
    static func removeSectionContainerSpace(_ height: CGFloat, context: UIGraphicsPDFRendererContext) {
        if height < effectiveSectionContainer.height {
            effectiveSectionContainer.origin.y += height
            effectiveSectionContainer.size.height -= height
        } else {
            beginNewPage(in: context)
        }
    }
    
    static var effectiveSectionContainer = CGRect.zero
    static private var effectiveSideContainer = CGRect.zero
    
    static func beginNewPage(in context: UIGraphicsPDFRendererContext) {
        context.beginPage()
        
        context.cgContext.drawLine(
            from: CGPoint(x: .zero, y: Constant.pagePadding),
            to: CGPoint(x: Constant.pageSize.width, y: Constant.pagePadding)
        )
        
        context.cgContext.drawLine(
            from: CGPoint(x: Constant.sideWidth, y: .zero),
            to: CGPoint(x: Constant.sideWidth, y: Constant.pageSize.height)
        )
        
        effectiveSectionContainer = CGRect(
            x: Constant.sideWidth + Constant.pagePadding,
            y: Constant.pagePadding * 2,
            width: Constant.pageSize.width - 2 * Constant.pagePadding - Constant.sideWidth,
            height: Constant.pageSize.height - Constant.pagePadding * 3
        )
        
        effectiveSideContainer = CGRect(
            x: Constant.pagePadding,
            y: Constant.pagePadding * 2,
            width: Constant.sideWidth - Constant.pagePadding * 2,
            height: Constant.pageSize.height - Constant.pagePadding * 3
        )
        
        renderSide(in: context)
    }
    
    private static func renderSide(in context: UIGraphicsPDFRendererContext) {
        
        guard let side = remainingSides.first else { return }
        
        let sideRectangle = SideRectangle(content: side, container: effectiveSideContainer)
        
        if effectiveSideContainer.height < sideRectangle.contentSize.height + Constant.sideSpacing {
            return
        }
        
        sideRectangle.render(in: context)
        effectiveSideContainer.origin.y += sideRectangle.contentSize.height + Constant.sideSpacing
        effectiveSideContainer.size.height -= sideRectangle.contentSize.height + Constant.sideSpacing
        remainingSides.removeFirst()
//        renderSide(in: context)
    }
}

extension Array where Element == Rectangle {
    
    var height: CGFloat {
        return reduce(0) { $0 + $1.contentSize.height }
    }
}
