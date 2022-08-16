import UIKit
import CoreData

class RecipeDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: RecipeDetailsViewModel
    var image = UIImageView()
    let label = UILabel()
    var textView = UITextView()
    let defaultImage = UIImage(named: "defaultForkKnifeSpoon")
    let getDirectionsButton = UIButton()
    
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
        
        viewModel.delegate = self
      
        setupViews()
        setupLayouts()
        
        viewModel.checkIfRecipeFavorite()
        
    }
    
    func setupViews() {
        
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor = .label
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addToFavourites))
        
        if let foodImageFromURL = viewModel.recipe.foodImage {
        image.loadFrom(URLAddress: foodImageFromURL)
        } else {
            image = UIImageView(image: defaultImage)
            image.contentMode = .scaleToFill
        }
        view.addSubview(image)
        view.backgroundColor = .white
        
        label.text = viewModel.recipe.name
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        view.addSubview(label)
        
        let ingredients = viewModel.recipe.ingredientLines.map { "\($0)" }.joined(separator: "\n- ")
        
        textView.text = "- " + String(ingredients)
        textView.font = .preferredFont(forTextStyle: .title2)
        textView.backgroundColor = .systemGray
        view.addSubview(textView)
        
        getDirectionsButton.setTitle("Get directions", for: .normal)
        getDirectionsButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        getDirectionsButton.backgroundColor = .systemGray
        getDirectionsButton.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        view.addSubview(getDirectionsButton)
    }
    
    func setupLayouts() {
        [image, label, textView, getDirectionsButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .zero),
            image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: .zero),
            image.heightAnchor.constraint(equalToConstant: 400),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            label.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -Margins.small),
            label.heightAnchor.constraint(equalToConstant: 35),
            
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            textView.bottomAnchor.constraint(equalTo: getDirectionsButton.topAnchor, constant: -Margins.small),
            
            getDirectionsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            getDirectionsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            getDirectionsButton.heightAnchor.constraint(equalToConstant: 42),
            getDirectionsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margins.small)
        ])
    }
    
    @objc
    func addToFavourites() {
        viewModel.toggelFavoriteStatus(for: viewModel.recipe)
        
        
        //        navigationItem.rightBarButtonItem?.style = .done
    }
    
    @objc
    func getDirections() {
        didTapGetDirectionsButton()
    }
    
    func didTapGetDirectionsButton() {
        guard let url = URL(string: viewModel.recipe.url) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

extension RecipeDetailsViewController: RecipeDetailsViewModelDelegate {
    func didToggleFavoriteStatusForREcipe(state: RecipeState) {
        switch state {
        case .isFavorite:
            navigationItem.rightBarButtonItem?.tintColor = .systemYellow
        case .isNotFavorite:
            navigationItem.rightBarButtonItem?.tintColor = .label
        }
    }
}

