//
//  RMGalleryCollectionModel.swift
//  Rijksmuseum
//
//  Created by Gor Stepanyan on 07.06.23.
//

import Foundation

struct RMGalleryCollectionModel: Decodable {
    let count: Int
    let artObjects: [RMArtModel]
}

struct RMArtModel: Decodable {
    let links: RMArtModelLinks
    let id: String
    let objectNumber: String
    let title: String
    let hasImage: Bool
    let principalOrFirstMaker: String
    let longTitle: String
    let showImage: Bool
    let permitDownload: Bool
    let webImage: RMArtModelImage
    let headerImage: RMArtModelImage
    let productionPlaces: [String]
    
    var webImageRatio: Float {
        if hasImage {
            return Float(webImage.width) / Float(webImage.height)
        }
        return 1
    }
    
    var headerImageRatio: Float {
        if hasImage {
            return Float(headerImage.width) / Float(headerImage.height)
        }
        return 1
    }
}

struct RMArtModelLinks: Decodable {
    let web: String
    let origin: String
    
    enum CodingKeys: String, CodingKey {
        case web
        case origin = "self"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        web = try container.decode(String.self, forKey: .web)
        origin = try container.decode(String.self,  forKey: .origin)
    }
}

struct RMArtModelImage: Decodable {
    let guid: String
    let offsetPercentageX: Int
    let offsetPercentageY: Int
    let width: Int
    let height: Int
    let url: String
}

class RMArtObjectSection {
    let header: String?
    var items: [RMArtModel]
    
    init(header: String?, items: [RMArtModel]) {
        self.header = header
        self.items = items
    }
}

extension RMGalleryCollectionModel {
    
    func toArtObjectSections() -> [RMArtObjectSection] {
        let modelsDict = Dictionary(grouping: artObjects, by: { $0.principalOrFirstMaker })
        return modelsDict.compactMap { (key: String, value: [RMArtModel]) in
            RMArtObjectSection(header: key, items: value)
        }
    }
}

 /*
  {
    "elapsedMilliseconds": 0,
    "count": 775857,
    "countFacets": {
      "hasimage": 594033,
      "ondisplay": 8438
    },
    "artObjects": [
      {
        "links": {
          "self": "http://www.rijksmuseum.nl/api/en/collection/BK-AM-33-E",
          "web": "http://www.rijksmuseum.nl/en/collection/BK-AM-33-E"
        },
        "id": "en-BK-AM-33-E",
        "objectNumber": "BK-AM-33-E",
        "title": "Ten weepers from the tomb of Isabella of Bourbon",
        "hasImage": true,
        "principalOrFirstMaker": "Borman workshop, Renier van Thienen (I)",
        "longTitle": "Ten weepers from the tomb of Isabella of Bourbon, Borman workshop (attributed to), Renier van Thienen (I) (attributed to), c. 1475 - c. 1476",
        "showImage": true,
        "permitDownload": true,
        "webImage": {
          "guid": "1a3bc6ce-d516-450b-836c-f4da1eaddefa",
          "offsetPercentageX": 0,
          "offsetPercentageY": 0,
          "width": 1655,
          "height": 2500,
          "url": "https://lh6.ggpht.com/z37VVIUgOOW4cumA4FvSwyvuMWdk6rjD7CBu1aAL5OGz_-RRuuQ2Xq4jEuHWn7plIwhD4bT2Qp8pnGRqbWPiNPpM0gwE=s0"
        },
        "headerImage": {
          "guid": "6e9c3453-3bbe-4e94-af7f-280c19931bfe",
          "offsetPercentageX": 0,
          "offsetPercentageY": 0,
          "width": 1920,
          "height": 460,
          "url": "https://lh3.ggpht.com/4ZApeLgijY_XxMxscXzTcMOnK_51Wl9YT2hswXucp_ESzZFykhHmM02xLoL9s6765IhaLueP2a4V7U-X-iBT7BWzlTth=s0"
        },
        "productionPlaces": [
          "Brussels"
        ]
      },
  */
