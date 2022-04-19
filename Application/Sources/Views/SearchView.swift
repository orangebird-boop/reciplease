import UIKit

protocol SearchViewDelegate: AnyObject {
    func didTapSearchButton()
}

class SearchView: UIView {
    var inTheFridge = UITextView()
    var myIngredients = UITextView()
    var searchButton = UIButton()
    
    weak var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSearchView() {
        setupView()
        setupLayout()
    }
    
    func setupView() {
        inTheFridge.text = "Fridge"
        inTheFridge.backgroundColor = .blue
        inTheFridge.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        addSubview(inTheFridge)
        
        myIngredients.text = "my ingredients"
        myIngredients.backgroundColor = .blue
        myIngredients.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        addSubview(myIngredients)

        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        searchButton.backgroundColor = .green
        searchButton.addTarget(self, action: #selector(searchForRecipes), for: .touchUpInside)
        addSubview(searchButton)
        
    }
    
    private func setupLayout() {
        [inTheFridge, myIngredients, searchButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            
            inTheFridge.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -16),
            inTheFridge.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            inTheFridge.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            inTheFridge.heightAnchor.constraint(equalToConstant: 42),
            
            myIngredients.topAnchor.constraint(equalTo: inTheFridge.bottomAnchor, constant: 8),
            myIngredients.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            myIngredients.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -24),
            myIngredients.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchButton.heightAnchor.constraint(equalToConstant: 42),
            searchButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    @objc
    func searchForRecipes() {
        delegate?.didTapSearchButton()
    }
}
