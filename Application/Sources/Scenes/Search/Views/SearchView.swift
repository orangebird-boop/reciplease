import UIKit

protocol SearchViewDelegate: AnyObject {
    func didTapSearchButton()
    func didTapAddButton()
}

class SearchView: UIView {
    var ingredientsTextField = UITextField()
    
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
        ingredientsTextField.text = ""
        ingredientsTextField.backgroundColor = .systemBackground
        ingredientsTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        addSubview(ingredientsTextField)
        
        addButton.setTitle("Add", for: .normal)
        addButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        addButton.backgroundColor = .systemGray
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        addSubview(addButton)
    }
    
    private func setupLayout() {
        [ingredientsTextField, addButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            
            ingredientsTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            ingredientsTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ingredientsTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ingredientsTextField.heightAnchor.constraint(equalToConstant: 32),
            
            addButton.topAnchor.constraint(equalTo: ingredientsTextField.bottomAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addButton.heightAnchor.constraint(equalToConstant: 42)
   
        ])
    }

    @objc
    func addIngredient() {
        delegate?.didTapAddButton()
    }
}
