//
//  Service.swift
//  NewsApp
//
//  Created by Gabriel de Castro Chaves on 04/08/22.
//

import Foundation

final class Service {
    
    func makeRequest(completion: @escaping (News) -> ()) {
        guard let url = URL(string: "https://v1.nocodeapi.com/gabrieldcc/xml_to_json/LLCYxlGwDUKvWjjH?url=https://g1.globo.com/rss/g1/carros/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.handleResponse(response)
            self.handleError(error)
            guard let responseData = data else { return }
            DispatchQueue.main.async {
                do {
                    let data = try JSONDecoder().decode(News.self, from: responseData)
                    completion(data)
                } catch let error {
                    print("error: \(error)")
                }
            }
        }
        task.resume()
    }
    
    private func handleResponse(_ response: URLResponse?) {
        print("response: \(String(describing: response))")
    }
    
    private func handleError(_ error: Error?) {
        print("error: \(String(describing: error))")
    }
    
}
    
    // MARK: - News
    struct News: Codable {
        let rss: RSS
    }
    
    // MARK: - RSS
    struct RSS: Codable {
        let empty: RSSClass
        let channel: Channel
        
        enum CodingKeys: String, CodingKey {
            case empty = "$"
            case channel
        }
    }
    
    // MARK: - Channel
    struct Channel: Codable {
        let title: String
        let link: String
        let channelDescription, language, copyright: String
        let atomLink: AtomLinkClass
        let image: Image
        let item: [Item]
        
        enum CodingKeys: String, CodingKey {
            case title, link
            case channelDescription = "description"
            case language, copyright
            case atomLink = "atom:link"
            case image, item
        }
    }
    
    // MARK: - AtomLinkClass
    struct AtomLinkClass: Codable {
        let empty: AtomLink
        
        enum CodingKeys: String, CodingKey {
            case empty = "$"
        }
    }
    
    // MARK: - AtomLink
    struct AtomLink: Codable {
        let href: String
        let rel, type: String
    }
    
    // MARK: - Image
    struct Image: Codable {
        let url: String
        let title: String
        let link: String
        let width, height: String
    }
    
    // MARK: - Item
    struct Item: Codable {
        let title: String
        let link: String
        let guid: GUIDClass
        let itemDescription: String
        let mediaContent: MediaContentClass?
        let category: Category
        let pubDate: String
        let source: SourceClass?
        
        enum CodingKeys: String, CodingKey {
            case title, link, guid
            case itemDescription = "description"
            case mediaContent = "media:content"
            case category, pubDate, source
        }
    }
    
    enum Category: String, Codable {
        case g1 = "G1"
    }
    
    // MARK: - GUIDClass
    struct GUIDClass: Codable {
        let guid: String
        let empty: GUID
        
        enum CodingKeys: String, CodingKey {
            case guid = "_"
            case empty = "$"
        }
    }
    
    // MARK: - GUID
    struct GUID: Codable {
        let isPermaLink: String
    }
    
    // MARK: - MediaContentClass
    struct MediaContentClass: Codable {
        let empty: MediaContent
        
        enum CodingKeys: String, CodingKey {
            case empty = "$"
        }
    }
    
    // MARK: - MediaContent
    struct MediaContent: Codable {
        let url: String
        let medium: Medium
    }
    
    enum Medium: String, Codable {
        case image = "image"
    }
    
    // MARK: - SourceClass
    struct SourceClass: Codable {
        let source: String
        let empty: Source
        
        enum CodingKeys: String, CodingKey {
            case source = "_"
            case empty = "$"
        }
    }
    
    // MARK: - Source
    struct Source: Codable {
        let url: String
    }
    
    // MARK: - RSSClass
    struct RSSClass: Codable {
        let xmlnsAtom, xmlnsMedia: String
        let version: String
        
        enum CodingKeys: String, CodingKey {
            case xmlnsAtom = "xmlns:atom"
            case xmlnsMedia = "xmlns:media"
            case version
        }
    }
    

