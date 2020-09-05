//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Japneet Singh on /59/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject{
    public var wrappedTitle: String{
        get{
            self.title ?? "Unknown Title"
        }
        
        set{
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String{
        get{
            self.subtitle ?? "Unknown Subtitle"
        }
        
        set{
            self.subtitle = newValue
        }
    }
}
