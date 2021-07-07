//
//  DetailViewController.swift
//  TestTask
//
//  Created by Maksym Levytskyi on 05.07.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailImageView: UIImageView!
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailImageView.image = image
    }
    @IBAction func shareAction(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        present(shareController, animated: true, completion: nil)
    }
}


