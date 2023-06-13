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

struct RMArtModel: Decodable, Hashable {
    let links: RMArtModelLinks
    let id: String
    let objectNumber: String
    let title: String
    let hasImage: Bool
    let principalOrFirstMaker: String
    let longTitle: String
    let description: String?
    let showImage: Bool
    let permitDownload: Bool?
    let webImage: RMArtModelImage?
    let headerImage: RMArtModelImage?
    let productionPlaces: [String]
    
    
    static func == (lhs: RMArtModel, rhs: RMArtModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(objectNumber)
    }
}

struct RMArtModelLinks: Decodable {
    let web: String?
    let origin: String?
    
    enum CodingKeys: String, CodingKey {
        case web
        case origin = "self"
    }
}

struct RMArtModelImage: Decodable {
    let guid: String?
    let offsetPercentageX: Int
    let offsetPercentageY: Int
    let width: Int
    let height: Int
    let url: String?
    
    var imageRatio: Float {
        guard width != 0 && height != 0 else { return 1 }
        
        return Float(width) / Float(height)
    }
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
