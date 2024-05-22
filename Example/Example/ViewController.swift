//
//  ViewController.swift
//  Example
//
//  Created by stat on 5/22/24.
//

import UIKit
import Oeschinen
import PDFKit

class ViewController: UIViewController {

    @IBOutlet weak var preview: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preview.document = PDFDocument(
            data: Builder.createPDF(
                header: headerContent,
                sides: sideContents,
                sections: sectionContents,
                footnote: footnote
            )
        )
        
        preview.autoScales = true
    }
    
    @IBAction func didTapShareButton(_ sender: UIBarButtonItem) {
        
        let path = FileManager.default.temporaryDirectory.appending(path: "resume.pdf")
        
        preview.document?.write(to: path)

        let activityViewController = UIActivityViewController(
            activityItems: [path],
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
