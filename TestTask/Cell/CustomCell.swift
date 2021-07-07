//
//  CustomCell.swift
//  TestTask
//
//  Created by Maksym Levytskyi on 06.07.2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static var idendifire = String(describing: CustomCell.self)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var downloadedImageView: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var imageViewButton: UIButton!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let downloadManager = DownloadManager()
    
    var delegate: CustomCellDelegate?
    
    var urlString: String!
    var image: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressBar.progress = 0
        percentLabel.isHidden = true
        imageViewButton.isHidden = true
    }
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        delegate?.downloadButtonTappped(tag: sender.tag)
    }
    
    @IBAction func resumeButtonTapped(_ sender: UIButton) {
        delegate?.resumeButtonTapped(tag: sender.tag)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        delegate?.cancelButtonTapped(tag: sender.tag)
    }
    @IBAction func imageViewButtonTapped(_ sender: UIButton) {
        delegate?.imageViewButtonTapped(tag: sender.tag)
    }
    
}
