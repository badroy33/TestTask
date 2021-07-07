//
//  TableViewController.swift
//  TestTask
//
//  Created by Maksym Levytskyi on 05.07.2021.
//

import UIKit

class TableViewController: UITableViewController, CustomCellDelegate {
    
    let imageUrlString = [ "https://images.pexels.com/photos/1525041/pexels-photo-1525041.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260",
                           "https://lh4.googleusercontent.com/proxy/W77hecSbOlUrrUgLm9dZeEP_Bjj8y0y0TTJMAoEJIYog1hwwuWkHnozaO1qFUUniqTo7ZnImARSVXUSe0iFck64OFdB3wXARPD448tjCHqW2ZCY7fBi-1EKEPuLE-95M5NPdSWqQIizaqphmsKWU_LQ5OQvT04FQ=s0-d",
                           "https://wallpapermemory.com/uploads/729/batman-arkham-knight-background-ultra-hd-8k-174195.jpg",
                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcg4TJAQmXG-EeGVyWoeeMgNnImCxgULO4g-NsKFaRWb-6TGz3mspkcmvt7I4AjhkErFY&usqp=CAU",
                           "https://images.wallpapersden.com/image/download/motocross-bike-racing_22534_7680x4320.jpg",
                           "https://images.wallpapersden.com/image/download/indian-roadmaster-classic-bike-2017_58265_7680x4320.jpg",
                           "https://wallpaperplay.com/walls/full/0/2/b/206416.jpg",
                           "https://images.pexels.com/photos/1643409/pexels-photo-1643409.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                           "https://wallpaperaccess.com/full/1207524.jpg",
                           "https://wallpaperaccess.com/full/87704.jpg",
                           "https://www.wallpaperu3.com/wp-content/mywallpapers/rise-of-the-tomb-raider-wallpaper-4k-8k-5120x2880.jpg",
                           "https://wallpaperplay.com/walls/full/a/9/8/159595.jpg",
                           "https://wallpaperplay.com/walls/full/5/5/a/159589.jpg",
                           "https://www.xtrafondos.com/wallpapers/rainbow-six-siege-nokk-3192.jpg",
                           "https://mocah.org/uploads/posts/192887-venom-7680x4320.jpg",
                           "https://a-static.besthdwallpaper.com/death-stranding-cliff-war-8k-4k-wallpaper-7680x4320-33755_56.jpg",
                           "https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                           "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                           "https://images.pexels.com/photos/3052361/pexels-photo-3052361.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                           "https://images.pexels.com/photos/1540258/pexels-photo-1540258.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
    ]
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cell = UINib(nibName: CustomCell.idendifire, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: CustomCell.idendifire)
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageUrlString.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let cell = Bundle.main.loadNibNamed(CustomCell.idendifire, owner: self, options: nil)?[0] as! CustomCell
        cell.nameLabel.text = "Image \(indexPath.row + 1)"
        cell.urlString = imageUrlString[indexPath.row]
        cell.delegate = self
        cell.downloadButton.tag = indexPath.row
        cell.resumeButton.tag = indexPath.row
        cell.cancelButton.tag = indexPath.row
        cell.imageViewButton.tag = indexPath.row
        if let image = imageCache.object(forKey: imageUrlString[indexPath.row] as NSString) as? UIImage{
            cell.downloadedImageView.image = image
            cell.configureCellForReuse()
        }
        
        return cell
    }
    
    
    //MARK: - CustomCellDelegate
    
    func downloadButtonTappped(tag: Int) {
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        cell.downloadManager.downloadTask(stringUrl: imageUrlString[tag])
        cell.downloadManager.image = { image in
            self.imageCache.setObject(image, forKey: self.imageUrlString[tag] as NSString)
            cell.downloadedImageView.contentMode = .scaleAspectFill
            cell.downloadedImageView.image = image
        }
        
        cell.downloadManager.onProgress = { progress in
            cell.percentLabel.isHidden = false
            cell.percentLabel.text = "\(Int(progress * 100))%"
            cell.progressBar.progress = progress
        }
        
        cell.downloadManager.finished = { finished in
            if finished {
                cell.imageViewButton.isHidden = false
                cell.downloadButton.isHidden = true
                cell.cancelButton.isHidden = true
                cell.resumeButton.isHidden = true
            }
        }
    }
    
    func resumeButtonTapped(tag: Int) {
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        cell.downloadManager.resumeDownload()
    }
    
    func cancelButtonTapped(tag: Int) {
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        cell.downloadManager.cancelDownload()
    }
    
    func imageViewButtonTapped(tag: Int) {
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        
        guard let image = cell.downloadedImageView.image else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.image = image
        
        present(detailVC, animated: true, completion: nil)
    }
}


