import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    var searchViewModel = SearchViewModel()  // (recipeIngredients: [])
    let searchView = SearchView()
    let ingredientsTableView = UITableView()
    var searchButton = UIButton()

    private lazy var dataSource = makeDataSource()
    
    enum Section {
        case first
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, String>
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.first])
        
        snapshot.appendItems(searchViewModel.ingredients)
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        DataSource(tableView: ingredientsTableView) { tableView, indexPath, model in
            guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
                fatalError("This cell should be registerd")
            }
            
            //            tableViewCell.configure(with: model)
            
            return tableViewCell
        }
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchViewModel.delegate = self
        
        setupViews()
        setupLayout()
    }
    
    func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        
        title = "Reciplease"
        
        searchView.delegate = self
        searchView.backgroundColor = .systemGray4
        view.addSubview(searchView)
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        searchButton.backgroundColor = .systemGray
        searchButton.addTarget(self, action: #selector(searchForRecipes), for: .touchUpInside)
        view.addSubview(searchButton)
        
        ingredientsTableView.backgroundColor = .systemBackground
        //        ingredientsTableView.delegate = self
        view.addSubview(ingredientsTableView)
    }
    
    func setupLayout() {
        [ingredientsTableView, searchView, searchButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margins.medium),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            searchView.heightAnchor.constraint(equalToConstant: 198),
            
            ingredientsTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: Margins.medium),
            ingredientsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            ingredientsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            ingredientsTableView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -Margins.small),
            
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            searchButton.heightAnchor.constraint(equalToConstant: 42),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margins.small)
        ])
        applySnapshot()
    }
    
    @objc
    func searchForRecipes() {
        didTapSearchButton()
    }
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func didTapSearchButton() {
        searchViewModel.searchRecipes(ingredients: searchViewModel.ingredients)
    }
    
    func didTapAddButton() {
        guard let ingredient = searchView.ingredientsTextField.text, !ingredient.isEmpty else {return}
        
        searchViewModel.add(ingredient: ingredient)
        
        searchView.ingredientsTextField.text = ""
        applySnapshot()
    }
    
    func didTapClearButton() {
        searchViewModel.ingredients.removeAll()
        searchView.ingredientsTextField.text = ""
        
        applySnapshot()
    }
    
    func didTapTextField() {
        searchView.ingredientsTextField.text = ""
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didNotFindRecipe(error: SearchViewModelError) {
        
        let alertViewController = UIAlertController(title: "Error", message: "huston we have a problem", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
        
    }
    
    func didUpgradeIngredients() {
        ingredientsTableView.reloadData()
    }
    
    func didFindRecipes() {
        let viewController = SearchResultViewController(viewModel: SearchResultViewModel(recipes: searchViewModel.recipes))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let ingredient = dataSource.indexPath(for: SearchTableViewCell.identifier) else {
            return
        }
    }
}

//    private func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
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
// }
