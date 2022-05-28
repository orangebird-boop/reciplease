import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultTableViewCell"
    var foodImageView = UIImageView()
    let gradientLayer = CAGradientLayer()
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        
        return label
    }()
    private var recipe: Recipe?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        self.recipe = recipe
        label.text = recipe.name
        
        if let foodImageFromUrl = recipe.foodImage {
            foodImageView.loadFrom(URLAddress: foodImageFromUrl)
        } else {
            // Choose default image
        }
    }
    
    func setupViews() {
//        contentView.addSubview(label)
//        contentView.addSubview(foodImage)
        
        let foodImage = UIImageView(frame: .zero)
        self.contentView.addSubview(foodImage)
        self.foodImageView = foodImage
        
        let label = UILabel(frame: .zero)
        self.contentView.addSubview(label)
        self.label = label
        
        gradientLayer.colors = [UIColor.clear, UIColor.black]
             gradientLayer.locations = [0.6, 1.0]
             gradientLayer.frame = self.bounds
             self.layer.insertSublayer(gradientLayer, below: self.foodImageView.layer)
        
    }
    
    func setupLayout() {
        [foodImageView, label].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            foodImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
