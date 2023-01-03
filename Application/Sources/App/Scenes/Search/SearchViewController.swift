import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    
    var searchViewModel = SearchViewModel()
    let searchView = SearchView()
    let ingredientsTableView = UITableView()
    var searchButton = UIButton()
    
    private lazy var dataSourceProvider = SearchViewIngredientsDataSourceProvider(tableView: ingredientsTableView)
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchViewModel.delegate = self
        dataSourceProvider.dataSource.delegate = self
        
        setupViews()
        setupLayout()
        
        self.isAccessibilityElement = true
        applyAccessibility()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        enableSearchButton()
        
        dataSourceProvider.applySnapshot(ingredients: searchViewModel.ingredients)
    }
    
    func setupViews() {
        view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.title = "Reciplease"
        
        searchView.delegate = self
        searchView.backgroundColor = .white
        view.addSubview(searchView)
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.isEnabled = false
        searchButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        searchButton.backgroundColor = .systemGray
        searchButton.addTarget(self, action: #selector(searchForRecipes), for: .touchUpInside)
        view.addSubview(searchButton)
        
        ingredientsTableView.backgroundColor = .black
        ingredientsTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.addSubview(ingredientsTableView)
    }
    
    func setupLayout() {
        [ingredientsTableView, searchView, searchButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margins.medium),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchView.heightAnchor.constraint(equalToConstant: Margins.medium*11),
            
            ingredientsTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: Margins.medium),
            ingredientsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            ingredientsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            ingredientsTableView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -Margins.small),
            
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            searchButton.heightAnchor.constraint(equalToConstant: 42),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margins.small)
        ])
    }
    
    @objc
    func searchForRecipes() {
        didTapSearchButton()
    }
    
    private func applyAccessibility() {
        
        searchView.ingredientsTextField.accessibilityLabel = "text field"
        searchView.ingredientsTextField.accessibilityHint = "type your ingredient here"
        searchView.addButton.accessibilityLabel = "add ingredient"
        searchView.clearAllButton.accessibilityLabel = "clear all ingredients"
        searchView.label.accessibilityLabel = "your ingredients"
        
        searchButton.accessibilityLabel = "Search for recipes"
    }
    
    func enableSearchButton() {
        
        if !searchViewModel.ingredients.isEmpty {
            searchButton.isEnabled = true
            searchButton.backgroundColor = .systemGreen
        } else {
            searchButton.isEnabled = false
            searchButton.backgroundColor = .systemGray
        }
    }
    
    func toggleSearchButton(isEnabled: Bool) {
        
        searchButton.isEnabled = isEnabled
        searchButton.backgroundColor = isEnabled ? .systemGreen : .systemGray
        
    }
}

// MARK: - Extentions

extension SearchViewController: SearchViewDelegate {
    
    func didTapSearchButton() {
        searchViewModel.searchRecipes()
        toggleSearchButton(isEnabled: false)
    }
    
    func didTapAddButton() {
        guard let ingredient = searchView.ingredientsTextField.text, !ingredient.isEmpty else {return}
        searchView.toggleAddButton(value: "")
        searchViewModel.add(ingredient: ingredient)
        searchView.ingredientsTextField.text = ""
        enableSearchButton()
        dataSourceProvider.applySnapshot(ingredients: searchViewModel.ingredients)
    }
    
    func didTapClearButton() {
        searchViewModel.clearAll()
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func noMatch() {
        let alertViewController = UIAlertController(title: "Error", message: "No recipes found, check your ingredients", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
    func didNotFindRecipe(error: SearchViewModelError) {
        toggleSearchButton(isEnabled: true)
        
        let alertViewController = UIAlertController(title: "Error", message: "Huston we have a problem", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
        
    }
    
    func didUpdateIngredients() {
        dataSourceProvider.applySnapshot(ingredients: searchViewModel.ingredients)
    }
    
    func didFindRecipes() {
        toggleSearchButton(isEnabled: true)
        let viewController = RecipesViewController(viewModel: RecipesViewModel(recipes: searchViewModel.recipes, nextURL: searchViewModel.nextUrl))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didNotUpdateIngredients(error: SearchViewModelError) {
        let alertViewController = UIAlertController(title: "Error", message: "Sorry, you can't use the same ingredient two times", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
}

extension SearchViewController: SearchDataSourceDelegate {
    
    func didDelete(ingredient: String) {
        searchViewModel.delete(ingredient: ingredient)
    }
}
