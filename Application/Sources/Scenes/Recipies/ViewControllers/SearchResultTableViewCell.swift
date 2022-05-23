import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultTableViewCell"
    var foodImage = UIImageView()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .black
        
        return label
    }()
    private var recipe: Recipe?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        self.recipe = recipe
        label.text = recipe.name
        foodImage.loadFrom(URLAddress: recipe.foodImage!)  //where do i unwrapp it?
        
    }
    
    func setupViews() {
        contentView.addSubview(label)
        contentView.addSubview(foodImage)
        
    }
    
    func setupLayout() {
        [label, foodImage].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}


