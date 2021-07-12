//
//  DownloadManager.swift
//  TestTask
//
//  Created by Maksym Levytskyi on 05.07.2021.
//

import Foundation
import UIKit

class DownloadManager: NSObject, URLSessionDownloadDelegate {
    var onProgress: ((Float) -> ())?
    var image: ((UIImage) -> ())?
    var finished: ((Bool) -> ())?
    private var taskStoped: Bool = false
    private var taskStarted: Bool = false
    
    private var task: URLSessionDownloadTask?
    private var session: URLSession {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        return session
    }
    private var resumeData: Data?
    
    
    func downloadTask(stringUrl: String) {
        if !taskStoped, !taskStarted {
            guard let url = URL(string: stringUrl) else {
                print("Can't get url")
                return
            }
            task = session.downloadTask(with: url)
            task?.resume()
            taskStarted = true
        }
    }
    
    func cancelDownload() {
        self.taskStoped = true
        task?.cancel(byProducingResumeData: { resumeDataOrNil in
            guard let resumeData = resumeDataOrNil else {
                print("No resume data")
                return
            }
            self.resumeData = resumeData
        })
    }
    
    func resumeDownload() {
        if taskStoped {
            guard let data = resumeData else {
                print("Download can't be resumed")
                return
            }
            
            task = session.downloadTask(withResumeData: data)
            task?.resume()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {

        guard let data = try? Data(contentsOf: location) else {
            print("Error")
            return
        }
        
        guard let image = UIImage(data: data) else { return }
        
        DispatchQueue.main.async {
            
            self.image?(image)
            self.finished?(true)
        }
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
}
