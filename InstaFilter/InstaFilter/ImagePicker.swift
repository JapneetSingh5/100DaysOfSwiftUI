//
//  ImagePicker.swift
//  InstaFilter
//
//  Created by Japneet Singh on /258/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ImagePicker : UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
}
