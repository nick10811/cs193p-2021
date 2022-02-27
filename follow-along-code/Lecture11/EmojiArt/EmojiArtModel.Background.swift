//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by Nick Yang on 2022/2/19.
//

import Foundation

extension EmojiArtModel {
    
    enum Background: Equatable, Codable {
        case blank
        case url(URL)
        case imageData(Data)
        
        init(from decoder: Decoder) throws {
            
        }
        
        enum CodingKeys: String, CodingKey {
            case url = "theURL" // convert actual key to mine (in the App)
            case imageData
        }
        
        func encode(to encoder: Encoder) throws {
            // keyedBy -> asking a type of enum,
            // self -> pass actual type of something
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .url(let url): try container.encode(url, forKey: .url)
            case .imageData(let data): try container.encode(data, forKey: .imageData)
            case .blank: break
            }
        }
        
        var url: URL? {
            switch self {
            case .url(let url): return url
            default: return nil
            }
        }
        
        var imageData: Data? {
            switch self {
            case .imageData(let data): return data
            default: return nil
            }
        }
    }
    
}
