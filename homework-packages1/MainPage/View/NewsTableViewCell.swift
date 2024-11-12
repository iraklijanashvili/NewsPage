import UIKit
import DateFormatting
import NewsNetworking

class NewsTableViewCell: UITableViewCell {
    let formater1 = CustomDateFormatter()
    let conteinerView = UIView()
    var backgroundImageView = UIImageView()
    var titleLable = UILabel()
    var authorLable = UILabel()
    var dateLable = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .clear
        setUpUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradient = CAGradientLayer()
        gradient.frame = backgroundImageView.bounds
        let endColor = UIColor.black.cgColor
        gradient.startPoint = CGPoint(x: 0.5, y: 0.35)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        backgroundImageView.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        backgroundImageView.layer.insertSublayer(gradient, at: 0)
    }

    
    private func setUpUI() {
        setUpConteinerView()
        setUpBackgroundImageView()
        setUpTitleLable()
        setUpAuthotLable()
        setUpDateLable()
    }
    
    private func setUpConteinerView() {
        contentView.addSubview(conteinerView)
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            conteinerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            conteinerView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        conteinerView.layer.cornerRadius = 8
    }
    
    private func setUpBackgroundImageView() {
        conteinerView.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: conteinerView.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: conteinerView.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor),
        ])
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.cornerRadius = 8
    }
    
    private func setUpTitleLable() {
        conteinerView.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 8),
            titleLable.leftAnchor.constraint(equalTo: conteinerView.leftAnchor, constant: 8),
            titleLable.rightAnchor.constraint(equalTo: conteinerView.rightAnchor, constant: -8)
        ])
        
        titleLable.font = UIFont(name: "Nunito-Bold", size: 12)
        titleLable.textAlignment = .left
        titleLable.numberOfLines = 0
        titleLable.textColor = .white
    }
    
    private func setUpAuthotLable() {
        conteinerView.addSubview(authorLable)
        authorLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorLable.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -8),
            authorLable.leftAnchor.constraint(equalTo: conteinerView.leftAnchor, constant: 16)
        ])
        
        authorLable.font = UIFont(name: "Nunito-Bold", size: 12)
        authorLable.textAlignment = .left
        authorLable.textColor = .white
    }
    
    private func setUpDateLable() {
        conteinerView.addSubview(dateLable)
        dateLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLable.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -8),
            dateLable.rightAnchor.constraint(equalTo: conteinerView.rightAnchor, constant: -16)
        ])
        
        dateLable.font = UIFont(name: "Nunito-Bold", size: 12)
        dateLable.textAlignment = .right
        dateLable.textColor = .white
    }
    
    func configureNewsTableViewCell(currentNews: NewsModel) {
        self.titleLable.text = currentNews.title
        self.authorLable.text = currentNews.author
        self.dateLable.text = formater1.formatDate(from: currentNews.publishedAt ?? "")
        if let imageUrlString = currentNews.urlToImage, let url = URL(string: imageUrlString) {
                self.backgroundImageView.load(url: url)
            } else {
                self.backgroundImageView.image = UIImage(named: "noimage")
            }
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
