//
//  FileManager.swift
//  BaseProject
//
//  Created by Rohit Makwana on 07/06/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

fileprivate var documentsDirectoryPath : String? {
    
    get {
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory: AnyObject = paths[0] as AnyObject
        return documentsDirectory as? String
    }
}


extension FileManager {
    
//    func clearDirectory(ForPath path: String) {
//
//        do {
//            let tmpDirectory = try contentsOfDirectory(atPath: NSTemporaryDirectory())
//            try tmpDirectory.forEach {[unowned self] file in
//                let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
//                try self.removeItem(atPath: path)
//            }
//        } catch {
//            print(error)
//        }
//    }
    
    func getDocumentDirectoryPath() -> String {
        
        return documentsDirectoryPath! + "/"
    }
    
    
    //MARK:- Create & Update Document Directort path
    func createDirectoryWith(_ dir: String) {
        
        do {
            
            try DefaultFileManager.createDirectory(atPath: dir, withIntermediateDirectories: false, attributes: nil)
            
            print()
            print("===========================================================================================")
            print(" Directory Path: \(dir) ")
            print("===========================================================================================")
            print()
            
        } catch let error as NSError {
            
            print(error.localizedDescription);
        }
    }
    
    func checkFileExistAtPath(_ path: String) -> Bool {
        
        return DefaultFileManager.fileExists(atPath: path)
    }
    
    func removeItem(_ path: String) {
        
        do {
            
            try DefaultFileManager.removeItem(atPath: path)
            print("===========================================================================================")
            print(" Removed Directory : \(path) ")
            print("===========================================================================================")
        }
        catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }

    
    func saveImageAtPath(_ path: String , image: UIImage) {
        
        let finalPath = URL(string: path)

        if let data = image.jpegData(compressionQuality:  0.65),
            !DefaultFileManager.fileExists(atPath: finalPath!.path) {
            
            DefaultFileManager.createFile(atPath: path, contents: data, attributes: nil)
            
            
//            do {
//
//
//                try data.write(to: finalPath!)
//                print("file saved")
//            } catch {
//                print("error saving file:", error)
//            }
        }
    }
}
