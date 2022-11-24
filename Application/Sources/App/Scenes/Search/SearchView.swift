import UIKit
import SwiftUI

protocol SearchViewDelegate: AnyObject {
    func didTapAddButton()
    func didTapClearButton()
    func didUseTextField()
}
class SearchView: UIView {
    // MARK: - Properties
    
    var ingredientsTextField = UITextField()
    var addButton = UIButton()
    var clearAllButton = UIButton()
    var label = UILabel()
    var bottomLine = CALayer()
    
    weak var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Functions
    
    func setupSearchView() {
        setupView()
        setupLayout()
    }
    
    func setupView() {
        bottomLine.frame = CGRect(x: 0.0, y: ingredientsTextField.frame.height - 1, width: ingredientsTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.green.cgColor
        
        ingredientsTextField.borderStyle = UITextField.BorderStyle.none
        ingredientsTextField.layer.addSublayer(bottomLine)
        
        ingredientsTextField.placeholder = "Lemon, Cheese, Sausages..."
        ingredientsTextField.backgroundColor = .systemBackground
        ingredientsTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        ingredientsTextField.addTarget(self, action: #selector(didUseTextField), for: .touchUpInside)
        addSubview(ingredientsTextField)
        
        addButton.setTitle("Add", for: .normal)
        addButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        addButton.backgroundColor = .systemGray
        addButton.isEnabled = false
        addButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        addSubview(addButton)
        
        label.text = "Your ingredients :"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.backgroundColor = .white
        addSubview(label)
        
        clearAllButton.setTitle("Clear all", for: .normal)
        clearAllButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        clearAllButton.backgroundColor = .systemGray
        clearAllButton.addTarget(self, action: #selector(clearAll), for: .touchUpInside)
        addSubview(clearAllButton)
    }
    
    private func setupLayout() {
        [ingredientsTextField, addButton, label, clearAllButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            
            ingredientsTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Margins.medium),
            ingredientsTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margins.medium),
            ingredientsTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margins.medium),
            ingredientsTextField.heightAnchor.constraint(equalToConstant: 32),
            
            addButton.topAnchor.constraint(equalTo: ingredientsTextField.bottomAnchor, constant: Margins.medium),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margins.medium),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margins.medium),
            addButton.heightAnchor.constraint(equalToConstant: 42),
            
            label.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: Margins.medium),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margins.medium),
            label.trailingAnchor.constraint(equalTo: clearAllButton.leadingAnchor, constant: -Margins.medium),
            label.heightAnchor.constraint(equalToConstant: 42),
            
            clearAllButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: Margins.medium),
            clearAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Margins.medium),
            clearAllButton.heightAnchor.constraint(equalToConstant: 42),
            clearAllButton.widthAnchor.constraint(equalToConstant: 82)
            
        ])
    }
    
    @objc
    func addIngredient() {
        delegate?.didTapAddButton()
    }
    
    @objc
    func clearAll() {
        delegate?.didTapClearButton()
    }
    
    @objc
    func didUseTextField() {
        delegate?.didUseTextField()
    }
}
