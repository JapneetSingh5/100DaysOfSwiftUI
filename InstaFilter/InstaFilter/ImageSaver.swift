//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Japneet Singh on /318/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import UIKit

class ImageSaver: NSObject{
    func writeToPhotoAlbums(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
            errorHandler?(error)
        }
        else{
            successHandler?()
        }
    }
    
    var successHandler: (()->Void)?
    var errorHandler: ((Error)->Void)?
}
