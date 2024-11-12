
import Foundation
import NewsNetworking

final class News_ViewModel {
    
    private let networkService: NetworkService
    
    var newsArray = [NewsModel]()
    
    var newsChanged: (() -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        getNewsFrom()
    }
    
    func getNewsFrom() {
        let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=e43d9a74a6a143bfbfb545869a529d4b"
        networkService.fetchData(from: urlString) { [weak self] (result: Result<NewsResponseData, NetworkError>) in
            switch result {
            case .success(let data):
                self?.newsArray = data.articles ?? []
                self?.newsChanged?()
            case .failure(let error):
                print("Error fetching news: \(error)")
            }
        }
    }
    
    func currentNews(at index: Int) -> NewsModel {
        newsArray[index]
    }
    
    var numberOfNews: Int {
        newsArray.count
    }
}

