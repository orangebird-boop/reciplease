import Foundation
import UIKit

class RecipeDetailsViewController: UIViewController {

    // MARK: - Properties

    let viewModel: RecipeDetailsViewModel
    var image = UIImageView()
    let label = UILabel()
    let textView = UITextView()
    let defaultImage = UIImage(named: "defaultForkKnifeSpoon")
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayouts()
        
    }
    
     func setupViews() {
       
        view.backgroundColor = .systemBackground
        
        let buttonImage = UIImage(systemName: "star")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(addToFavourites))
        
        if let foodImageFromURL = viewModel.recipe.foodImage {
        image.loadFrom(URLAddress: foodImageFromURL)
        } else {
            image = UIImageView(image: defaultImage)
        }
        view.addSubview(image)
        
        label.text = viewModel.recipe.name
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        view.addSubview(label)
        
        textView.backgroundColor = .systemGray
        view.addSubview(textView)
    }
    
    func setupLayouts() {
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
