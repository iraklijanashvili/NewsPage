import UIKit
import DateFormatting

final class DetailsViewController: UIViewController {

    let formater1 = CustomDateFormatter()
    var headerLable = UILabel()
    private let backButton = UIButton()
    private let conteinerView = UIView()
    var titleLable = UILabel()
    var dateLable = UILabel()
    var imageView = UIImageView()
    var textLable = UILabel()
    private let publishedLable = UILabel()
    var authorLable = UILabel()
    
    private let news: NewsModel
    
    init(news: NewsModel) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        let endColor = UIColor.black.cgColor
        gradient.startPoint = CGPoint(x: 0.5, y: 0.35)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        imageView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        imageView.layer.insertSublayer(gradient, at: 0)
    }

    private func setUpUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        setUpHeaderLable()
        setUpBackButton()
        setUpConteinerView()
        setUpTitleLable()
        setUpDateLable()
        setUpImageView()
        setUpTextLable()
        setUpPublishedLable()
        setUpAuthorLable()
    }
    
    private func setUpHeaderLable() {
        view.addSubview(headerLable)
        headerLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            headerLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
        
        headerLable.text = "Hot Updates"
        headerLable.font = UIFont(name: "AnekDevanagari-Medium_Bold", size: 17)
        headerLable.textAlignment = .center
        headerLable.textColor = .black
    }
    
    private func setUpBackButton() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.28),
            backButton.centerYAnchor.constraint(equalTo: headerLable.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 6.50),
            backButton.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        
        backButton.addAction(UIAction(handler: { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
            print("pressed")
        }), for: .touchUpInside)
    }
    
    private func setUpConteinerView() {
        view.addSubview(conteinerView)
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: headerLable.bottomAnchor, constant: 12),
            conteinerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            conteinerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12)
        ])
    }
    
    private func setUpTitleLable() {
        conteinerView.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 20),
            titleLable.leftAnchor.constraint(equalTo: conteinerView.leftAnchor, constant: 3),
            titleLable.rightAnchor.constraint(equalTo: conteinerView.rightAnchor, constant: -3)
        ])
        
        titleLable.font = UIFont(name: "Nunito-Bold", size: 16)
        titleLable.numberOfLines = 0
        titleLable.textColor = .black
        titleLable.text = news.title
    }
    
    private func setUpDateLable() {
        conteinerView.addSubview(dateLable)
        dateLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 8),
            dateLable.leftAnchor.constraint(equalTo: conteinerView.leftAnchor, constant: 3),
            dateLable.rightAnchor.constraint(equalTo: conteinerView.rightAnchor, constant: -3)
        ])
        
        dateLable.font = UIFont(name: "Nunito-Regular", size: 12)
        dateLable.text = formater1.formatDate(from: news.publishedAt ?? "")
    }
    
    private func setUpImageView() {
        conteinerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: dateLable.bottomAnchor, constant: 11),
            imageView.leadingAnchor.constraint(equalTo: dateLable.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: dateLable.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 144)
        ])
        
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        if let imageUrlString = news.urlToImage, let url = URL(string: imageUrlString) {
                self.imageView.load(url: url)
            } else {
                self.imageView.image = UIImage(named: "noimage")
            }
    }
    
    private func setUpTextLable() {
        conteinerView.addSubview(textLable)
        textLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            textLable.leadingAnchor.constraint(equalTo: titleLable.leadingAnchor),
            textLable.trailingAnchor.constraint(equalTo: titleLable.trailingAnchor)
        ])
        
        textLable.font = UIFont(name: "Nunito-Regular", size: 14)
        textLable.textColor = .black
        textLable.numberOfLines = 0
        textLable.text = news.content
    }
    
    private func setUpPublishedLable() {
        conteinerView.addSubview(publishedLable)
        publishedLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            publishedLable.topAnchor.constraint(equalTo: textLable.bottomAnchor, constant: 8),
            publishedLable.leadingAnchor.constraint(equalTo: titleLable.leadingAnchor)
        ])
        
        publishedLable.font = UIFont(name: "Nunito-Bold", size: 12)
        publishedLable.text = "Published by"
    }
    
    private func setUpAuthorLable() {
        conteinerView.addSubview(authorLable)
        authorLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorLable.centerYAnchor.constraint(equalTo: publishedLable.centerYAnchor),
            authorLable.leftAnchor.constraint(equalTo: publishedLable.rightAnchor, constant: 14)
        ])
        
        authorLable.font = UIFont(name: "Nunito-Bold", size: 12)
        authorLable.text = news.author
    }
}

