//
//  Images.swift
//  Meetup
//
//  Created by Japneet Singh on /139/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

class Images: ObservableObject, Codable {
    @Published var images = [ImageData]()
    enum CodingKeys: CodingKey{
        case images
    }
    
    init(){
        
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        images = try container.decode([ImageData].self, forKey: CodingKeys.images)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(images, forKey: CodingKeys.images)
    }
}
