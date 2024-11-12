import UIKit
import NewsNetworking

final class MainScreenViewController: UIViewController {
    
    private let viewModel = News_ViewModel(networkService: NetworkService())
    
    let titleLable = UILabel()
    let tableViewForNews = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        setUpTitleLable()
        setUpTableViewForNews()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.newsChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.tableViewForNews.reloadData()
            }
        }
    }
    
    private func setUpTitleLable() {
        view.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 21)
        ])
        
        titleLable.text = "Latest News"
        titleLable.font = UIFont(name: "AnekDevanagari-Medium_Bold", size: 18)
        titleLable.textAlignment = .left
        titleLable.textColor = .black
    }
    
    private func setUpTableViewForNews() {
        view.addSubview(tableViewForNews)
        tableViewForNews.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableViewForNews.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 7),
            tableViewForNews.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableViewForNews.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            tableViewForNews.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableViewForNews.rowHeight = 128
        tableViewForNews.backgroundColor = .clear
        
        tableViewForNews.dataSource = self
        tableViewForNews.delegate = self
        tableViewForNews.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCellTableViewCell")
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfNews
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellTableViewCell", for: indexPath) as? NewsTableViewCell
        let currentNews = viewModel.currentNews(at: indexPath.row)
        cell?.configureNewsTableViewCell(currentNews: currentNews)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentNews = viewModel.currentNews(at: indexPath.row)
        let vc = DetailsViewController(news: currentNews)
        navigationController?.pushViewController(vc, animated: true)
    }
}
