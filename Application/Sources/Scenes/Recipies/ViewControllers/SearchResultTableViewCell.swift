import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultTableViewCell"
    var foodImageView = UIImageView()
    let defaultImage = UIImage(named: "defaultForkKnifeSpoon")
    let gradientLayer = CAGradientLayer()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .white
        
        return label
    }()
    
    lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.font = UIFont.preferredFont(forTextStyle: .body)
        ingredientsLabel.textColor = .white
        
        return ingredientsLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        timeLabel.textColor = .white

        return timeLabel
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
        titleLabel.text = recipe.name
        
        ingredientsLabel.text = recipe.ingredientLines.joined(separator: ", ")
        
        guard let preparationTime = recipe.totalTime else {return}
        timeLabel.text = "\(String(describing: preparationTime))"
//        timeLabel.text!.addImageWith(name: "clock", behindText: false)
        
        
        if let foodImageFromUrl = recipe.foodImage {
            foodImageView.loadFrom(URLAddress: foodImageFromUrl)
        } else {
            foodImageView.image = defaultImage
        }
    }
    
    func setupViews() {

        let foodImage = UIImageView(frame: .zero)
        self.contentView.addSubview(foodImage)
        self.foodImageView = foodImage
        
        self.contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        self.contentView.addSubview(timeLabel)
        self.timeLabel = timeLabel
 
        self.contentView.addSubview(ingredientsLabel)
        self.ingredientsLabel = ingredientsLabel
        
        gradientLayer.colors = [UIColor.clear, UIColor.black]
             gradientLayer.locations = [0.6, 1.0]
             gradientLayer.frame = self.bounds
             self.layer.insertSublayer(gradientLayer, below: self.foodImageView.layer)
        
    }
    
    func setupLayout() {
        [foodImageView, titleLabel, ingredientsLabel, timeLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            foodImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            ingredientsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -Margins.small),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.medium),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.medium)
            
        ])
    }
}
