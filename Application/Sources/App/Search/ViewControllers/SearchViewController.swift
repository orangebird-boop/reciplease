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
        
        setupViews()
        setupLayout()
        
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
        searchButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        searchButton.backgroundColor = .systemGreen
        searchButton.addTarget(self, action: #selector(searchForRecipes), for: .touchUpInside)
        view.addSubview(searchButton)
        
        ingredientsTableView.backgroundColor = .black
        ingredientsTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        ingredientsTableView.delegate = self
        view.addSubview(ingredientsTableView)
        
        dataSourceProvider.dataSource.defaultRowAnimation = .fade
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
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func didTapSearchButton() {
        searchViewModel.searchRecipes()
        searchViewModel.ingredients.removeAll()
    }
    
    func didTapAddButton() {
        guard let ingredient = searchView.ingredientsTextField.text, !ingredient.isEmpty else {return}
        
        searchViewModel.add(ingredient: ingredient)
        
        searchView.ingredientsTextField.text = ""
        dataSourceProvider.applySnapshot(ingredients: searchViewModel.ingredients)
    }
    
    func didTapClearButton() {
        searchViewModel.ingredients.removeAll()
        searchView.ingredientsTextField.text = ""
        
        dataSourceProvider.applySnapshot(ingredients: searchViewModel.ingredients)
    }
    
    func didTapTextField() {
        searchView.ingredientsTextField.text = ""
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didNotFindRecipe(error: SearchViewModelError) {
        
        let alertViewController = UIAlertController(title: "Error", message: "Huston we have a problem", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
        
    }
    
    func didUpgradeIngredients() {
        dataSourceProvider.applySnapshot(ingredients: searchViewModel.ingredients)
    }
    
    func didFindRecipes() {
        let viewController = SearchResultViewController(viewModel: SearchResultViewModel(recipes: searchViewModel.recipes))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didNotUpdateIngredients(error: SearchViewModelError) {
        let alertViewController = UIAlertController(title: "Error", message: "Sorry, you can't use the same ingredient two times", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard dataSourceProvider.dataSource.itemIdentifier(for: indexPath) != nil else {
            return
        }
    }
    
    private func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSourceProvider.applySnapshot(ingredients: searchViewModel.ingredients)
        }
    }
    
    
    
//        private func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) -> UITableViewCell.EditingStyle {
//            return .delete
//        }
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            tableView.beginUpdates()
    //
    //            let index = indexPath.first!
    //            searchViewModel.deleteIngredient(index: index)
    //
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //
    //            tableView.endUpdates()
    //        }
    //    }
}
