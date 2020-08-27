//
//  DirectoryManager.swift
//  AxxessTechPOC
//
//  Created by Rajesh Deshmukh on 27/08/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class DirectoryManager {
    
    private init() {}
    static let shared = DirectoryManager()
    
    func clearTempFolder() {
           let fileManager = FileManager.default
           let tempFolderPath = NSTemporaryDirectory()
           do {
               let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
               for filePath in filePaths {
                   try fileManager.removeItem(atPath: tempFolderPath + filePath)
               }
           } catch {
               print("Could not clear temp folder: \(error)")
           }
       }
    
    /// save Image in document directory using image object and file path
    
    func saveImageDocumentDirectory(image: UIImage, path: String) {
        
        let writePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(path).png")
        
        if let data = image.jpegData(compressionQuality:  1.0),
            !FileManager.default.fileExists(atPath: writePath.path ) {
            do {
                // writes the image data to disk
                try data.write(to: writePath)
                
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    ///  get Image from document directory using file path
    
    func getImageFromDocumentDirectory(fileName: String) -> UIImage {
       
        let fileManager = FileManager.default
        var fileUrl: URL = URL(fileURLWithPath: NSTemporaryDirectory())
        fileUrl.appendPathComponent(fileName)
        fileUrl.appendPathExtension("png")
        if fileManager.fileExists(atPath: fileUrl.path) {
            let getImageFromDirectory = UIImage(contentsOfFile: fileUrl.path) // get this image from Document Directory And Use This Image In Show In Imageview
            return getImageFromDirectory!
        }
        else {
            return UIImage(named: AppConstants.AppImage.placeholder)!
        }
        
    }
    
}
