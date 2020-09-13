//
//  ImageData.swift
//  Meetup
//
//  Created by Japneet Singh on /139/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation
import UIKit

struct ImageData: Identifiable, Comparable, Codable {
    
    enum CodingKeys: CodingKey{
        case id, image, personName, personCompany, meetup, date
    }
    
    static func < (lhs: ImageData, rhs: ImageData) -> Bool {
        lhs.personName < rhs.personName
    }
    
    init(image: UIImage, personName: String, personCompany: String, meetup: String, date: Date){
        self.image = image
        self.personCompany = personCompany
        self.personName = personName
        self.meetup = meetup
        self.date = date
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        personName = try container.decode(String.self, forKey: .personName)
        personCompany = try container.decode(String.self, forKey: .personCompany)
        meetup = try container.decode(String.self, forKey: .meetup)
        date = try container.decode(Date.self, forKey: .date)
        if let tempImg = try container.decode(Data?.self, forKey: .image){
            image = UIImage(data: tempImg) ?? UIImage(imageLiteralResourceName: "default")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(personName, forKey: .personName)
        try container.encode(personCompany, forKey: .personCompany)
        try container.encode(meetup, forKey: .meetup)
        try container.encode(date, forKey: .date)
        if let jpegData = self.image.jpegData(compressionQuality: 0.8) {
            try container.encode(jpegData, forKey: .image)
        }
        
    }
    
    var id = UUID()
    var image = UIImage(imageLiteralResourceName: "default")
    var personName: String = "John Doe"
    var personCompany: String = "Indie Developer"
    var meetup: String = "SwiftCon 2020"
    var date: Date = Date()
    
}
