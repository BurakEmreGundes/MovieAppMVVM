//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Burak Emre gündeş on 15.07.2023.
//

import Foundation


struct YoutubeSearchResponse : Codable {
    let items : [VideoElement]
}

struct VideoElement : Codable {
    let id : IDVideoElement
}

struct IDVideoElement : Codable {
    let kind : String
    let videoId: String
}
