//
//  File.swift
//  
//
//  Created by stat on 5/22/24.
//

import Foundation
import UIKit

struct ImageBuilder {
    
    static func cropImage(image: UIImage, size: CGSize) -> UIImage {
        
        let originalSize = image.size
        
        let widthRatio = size.width / originalSize.width
        let heightRatio = size.height / originalSize.height
        let scaleRatio = max(widthRatio, heightRatio)
        
        let newSize = CGSize(width: originalSize.width * scaleRatio, height: originalSize.height * scaleRatio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cropRect = CGRect(
            x: (newSize.width - size.width) / 2,
            y: (newSize.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
        
        guard let cgImage = resizedImage?.cgImage?.cropping(to: cropRect) else {
            return image
        }
        
        return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}

