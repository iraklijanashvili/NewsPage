
import Foundation

final class NewsModel: Decodable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    init(source: Source? = nil, author: String? = nil, title: String? = nil, description: String? = nil, url: String? = nil, urlToImage: String? = nil, publishedAt: String? = nil, content: String? = nil) {
        self.source = source
        self.author = author ?? "not founf"
        self.title = title ?? "not founf"
        self.description = description ?? "not founf"
        self.url = url ?? "not founf"
        self.urlToImage = urlToImage ?? "not founf"
        self.publishedAt = publishedAt ?? "not founf"
        self.content = content ?? "not founf"
    }
}

final class Source: Decodable {
    var id: String?
    var name: String?
}

struct NewsResponseData: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [NewsModel]?
}
