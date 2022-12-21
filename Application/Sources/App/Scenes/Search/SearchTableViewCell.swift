import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .white
        
        return label
    }()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with ingredient: String) {
        titleLabel.text = "- " + ingredient 
    }
    
    func setupViews() {
        backgroundColor = .clear
        
        titleLabel.tintColor = .black
        titleLabel.backgroundColor = .black
        self.contentView.addSubview(titleLabel)
    }
    
    func setupLayout() {
        [titleLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
