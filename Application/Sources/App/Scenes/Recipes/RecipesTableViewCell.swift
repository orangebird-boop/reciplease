import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultTableViewCell"
    var foodImageView = UIImageView()
    let opaqueLayer = UIView()
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
        timeLabel.textAlignment = .right
        timeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        timeLabel.textColor = .white
        
        return timeLabel
    }()
    
    private var recipe: Recipe?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
        
        self.isAccessibilityElement = true
        applyAccessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        self.recipe = recipe
        titleLabel.text = recipe.name
        
        ingredientsLabel.text = recipe.ingredientLines.joined(separator: ", ")
        
        guard let preparationTime = recipe.totalTime else {return}
        timeLabel.text = "\(String(describing: preparationTime)) min"
        
        if let foodImageFromUrl = recipe.foodImage {
            foodImageView.loadFrom(URLAddress: foodImageFromUrl)
        } else {
            foodImageView.image = defaultImage
        }
    }
    
    func setupViews() {
        
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.clipsToBounds = true
        contentView.addSubview(foodImageView)
        
        opaqueLayer.backgroundColor = .black.withAlphaComponent(1/4)
        contentView.addSubview(opaqueLayer)
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(timeLabel)
        
        contentView.addSubview(ingredientsLabel)
        
    }
    
    func setupLayout() {
        [foodImageView, opaqueLayer, titleLabel, ingredientsLabel, timeLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            opaqueLayer.topAnchor.constraint(equalTo: contentView.topAnchor),
            opaqueLayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            opaqueLayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            opaqueLayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            ingredientsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -Margins.small),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.big),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.medium)
            
        ])
    }
    
    func applyAccessibility() {
        accessibilityLabel = recipe?.name
    }
}
