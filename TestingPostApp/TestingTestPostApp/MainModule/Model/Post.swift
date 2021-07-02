//
//  Post.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let data: PostData
}

// MARK: - PostData
struct PostData: Codable {
    let items: [Item]
    let cursor: String?
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let isCreatedByPage: Bool?
    let videoElementID: JSONNull?
    let status, type: String
    let coordinates: JSONNull?
    let isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile: Bool
    let contents: [Content]
    let language: String
    let awards: Awards
    let createdAt, updatedAt: Int
    let isSecret: Bool
    let page: JSONNull?
    let author: Author?
    let stats: Stats
    let isMyFavorite: Bool
    
    var firstContentImageURL: URL? {
        var result: URL?
        
        contents.forEach { content in
            switch content.type {
            case "IMAGE":
                if let string = content.data.original?.url, let url = URL(string: string) {
                    result = url
                    break
                }
                
            case "IMAGE_GIF":
                if let string = content.data.original?.url, let url = URL(string: string) {
                    result = url
                    break
                }
                
            case "VIDEO":
                if let string = content.data.original?.url, let url = URL(string: string) {
                    result = url
                    break
                }
                
            default:
                break
            }
        }
        
        return result
    }
    var contentDescriptionText: String? {
        var result: String?
        
        contents.forEach { content in
                  
            switch content.type {
            case "TEXT":
                if let text = content.data.value {
                    result = text
                }
            default:
                break
            }
        }
        return result
    }

    enum CodingKeys: String, CodingKey {
            case id, isCreatedByPage
            case videoElementID = "videoElementId"
            case status, type, coordinates, isCommentable, hasAdultContent, isAuthorHidden, isHiddenInProfile, contents, language, awards, createdAt, updatedAt, isSecret, page, author, stats, isMyFavorite
        }
}

// MARK: - Author
struct Author: Codable {
    let id: String
    let url: String?
    let name: String
    let banner: Photo?
    let photo: Photo?
    let gender: String
    let isHidden, isBlocked, allowNewSubscribers, showSubscriptions: Bool
    let showSubscribers, isMessagingAllowed: Bool
    let auth: Auth
    let statistics: Statistics
    let tagline: String
    let data: AuthorData
    let nameSpecialStyle, photoSpecialStyle, photoSpecialVariant: Int?
}

// MARK: - Auth
struct Auth: Codable {
    let isDisabled: Bool
    let lastSeenAt, level: Int
}

// MARK: - Photo
struct Photo: Codable {
    let type: TypeEnum
    let id: String
    let data: PhotoData
}

// MARK: - PhotoData
struct PhotoData: Codable {
    let extraSmall: ExtraLarge
    let small, medium, large, extraLarge: ExtraLarge?
    let original: ExtraLarge
}

// MARK: - ExtraLarge
struct ExtraLarge: Codable {
    let url: String
    let size: Size
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
}

enum TypeEnum: String, Codable {
    case image = "IMAGE"
    case imageGIF = "IMAGE_GIF"
}

// MARK: - AuthorData
struct AuthorData: Codable {
}

// MARK: - Statistics
struct Statistics: Codable {
    let likes: Int
    let thanks: Double
    let uniqueName: Bool
    let thanksNextLevel, subscribersCount, subscriptionsCount: Int
}

// MARK: - Awards
struct Awards: Codable {
    let recent: [String]
    let statistics: [Statistic]
    let voices: Double
    let awardedByMe: Bool
}

// MARK: - Statistic
struct Statistic: Codable {
    let id: String
    let count: Int
}

// MARK: - Content
struct Content: Codable {
    let data: ContentData
    let type: String
    let id: String?
}

// MARK: - ContentData
struct ContentData: Codable {
    let value: String?
    let duration: Double?
    let url: String?
    let small, original: ExtraLarge?
    let values: [String]?
    let size: Size?
    let previewImage: PreviewImage?
    let extraSmall, medium, large: ExtraLarge?
}

// MARK: - PreviewImage
struct PreviewImage: Codable {
    let type: TypeEnum
    let id: String
    let data: PreviewImageData
}

// MARK: - PreviewImageData
struct PreviewImageData: Codable {
    let extraSmall: ExtraLarge
}

// MARK: - Stats
struct Stats: Codable {
    let likes, views, comments, shares: Comments
    let replies: Comments
    let timeLeftToSpace: TimeLeftToSpace
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int
    let my: Bool
}

// MARK: - TimeLeftToSpace
struct TimeLeftToSpace: Codable {
    let count: Int?
    let maxCount: JSONNull?
    let my: Bool
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
}
