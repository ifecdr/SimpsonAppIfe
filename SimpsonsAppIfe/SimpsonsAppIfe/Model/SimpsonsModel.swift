//
//  SimpsonsModel.swift
//  SimpsonsApp
//
//  Created by MAC Consultant on 3/2/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import Foundation



struct Simpsons: Decodable {
    
    struct ImageStruct {
        var image: Data?
    }
    
    struct RelatedTopics: Decodable {
        var firstUrl : String
        var result: String
        var text: String
        var url: Icon
        //Custom Keys
        enum CodingKeys: String, CodingKey {
            case firstUrl = "FirstURL"
            case result = "Result"  //Custom keys
            case text = "Text" //Custom keys
            case url = "Icon"
        }
        
        
    }
    
    struct Icon: Decodable {
        var url: String
        
        enum CodingKeys: String, CodingKey {
            case url = "URL"
        }
    }
    
    let relatedTopics: [RelatedTopics]
    //let icon: [Icon]

  
}
extension Simpsons {
    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
        //case icon = "Icon"
    }
}
