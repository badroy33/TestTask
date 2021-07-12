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
    
    var progress: Float?
    
    var urlString: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        delegate?.downloadButtonTappped(tag: sender.tag)
        self.downloadButton.isHidden = true
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
    
    func configureCell() {
        imageViewButton.isHidden = true
        downloadedImageView.contentMode = .scaleAspectFit
        progressBar.progress = 0
        percentLabel.text = ""
    }
    
    
    func configureCellForReuse() {
        downloadedImageView.contentMode = .scaleAspectFill
        imageViewButton.isHidden = false
        cancelButton.isHidden = true
        downloadButton.isHidden = true
        resumeButton.isHidden = true
        percentLabel.isHidden = false
        percentLabel.text = "100%"
        progressBar.progress = 1
    }
    
    func configureCellWhileDownloading() {
        percentLabel.text = "\(Int(progress! * 100))%"
        progressBar.progress = progress!
        downloadButton.isHidden = true
        downloadedImageView.contentMode = .scaleAspectFit
    }
    
}
