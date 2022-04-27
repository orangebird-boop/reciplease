import UIKit

protocol SearchViewDelegate: AnyObject {
    func didTapSearchButton()
    func didTapAddButton()
}

class SearchView: UIView {
    var inTheFridge = UITextView()
    var myIngredients = SearchTableView()
    var searchButton = UIButton()
    var addButton = UIButton()
    
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
        inTheFridge.text = ""
        inTheFridge.backgroundColor = .white
        inTheFridge.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        addSubview(inTheFridge)
        
        addSubview(myIngredients)
        
        addButton.setTitle("Add", for: .normal)
        addButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        addButton.backgroundColor = .green
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        addSubview(addButton)

        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        searchButton.backgroundColor = .green
        searchButton.addTarget(self, action: #selector(searchForRecipes), for: .touchUpInside)
        addSubview(searchButton)
        
    }
    
    private func setupLayout() {
        [inTheFridge, myIngredients, addButton, searchButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            
            inTheFridge.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
//            inTheFridge.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            inTheFridge.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            inTheFridge.heightAnchor.constraint(equalToConstant: 42),
            
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.leadingAnchor.constraint(equalTo: inTheFridge.trailingAnchor, constant: 8),
            addButton.heightAnchor.constraint(equalToConstant: 42),
            addButton.widthAnchor.constraint(equalToConstant: 52),
            
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
    
    @objc
    func addIngredient() {
        delegate?.didTapAddButton()
    }
}
