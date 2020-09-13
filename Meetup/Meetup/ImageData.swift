//
//  ImageData.swift
//  Meetup
//
//  Created by Japneet Singh on /139/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation
import UIKit

struct ImageData: Identifiable{
    var id = UUID()
    var image = UIImage(imageLiteralResourceName: "default")
    var personName: String = "John Doe"
    var personCompany: String = "Indie Developer"
    var meetup: String = "SwiftCon 2020"
    var date: Date = Date()
}
