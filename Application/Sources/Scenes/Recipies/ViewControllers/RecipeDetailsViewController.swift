import Foundation
import UIKit

class RecipeDetailsViewController: UIViewController {

    // MARK: - Properties

    let viewModel: RecipeDetailsViewModel
    let image = UIImageView()
    let label = UILabel()
    let textView = UITextView()
//    let addToFavouritesButton = UIButton()
    // MARK: - Initialization
    
    init(viewModel: RecipeDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func configure(with recipe: Recipe) {
        viewModel.recipe = recipe
        label.text = recipe.name
        image.loadFrom(URLAddress: recipe.foodImage!)  // where do i unwrapp it?
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let buttonImage = UIImage(systemName: "star")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(addToFavourites))
       
        view.addSubview(image)
    
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        view.addSubview(label)
        
        textView.backgroundColor = .systemGray
        view.addSubview(textView)
    }
    
    func setupLayout() {
        [image, label, textView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            image.heightAnchor.constraint(equalToConstant: 400),
            
            label.heightAnchor.constraint(equalToConstant: 35),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -8),
            
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    @objc
    func addToFavourites() {
        
    }
}
