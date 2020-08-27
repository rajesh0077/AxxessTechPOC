//
//  Image+DownloadExtension.swift
//  TelstraApp
//
//  Created by RajeshDeshmukh on 30/06/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit
extension UIImageView {
    
    ///  function to download image from given URl
    /// - parameter String:  instance of link URL string
    
    func downloaded(from link: String, fileName: String) {
        
        let imageCache = NSCache<NSString, UIImage>()
        
        let defaultImage = UIImage(named: AppConstants.AppImage.placeholder)
        self.image = defaultImage
        
        let imageServerUrl = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: imageServerUrl) {
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = defaultImage
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                            DirectoryManager.shared.saveImageDocumentDirectory(image: downloadedImage, path: fileName)
                        }
                    }
                }
                
            }).resume()
        }
    }
 
}
