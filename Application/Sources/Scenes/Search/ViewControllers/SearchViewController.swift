import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    var searchViewModel = SearchViewModel()
    let searchView = SearchView()
    let ingredientsTableView = UITableView()
    var searchButton = UIButton()
//    private var sections = Section.first
//    private lazy var dataSource = makeDataSource()
//    
//    // MARK: - Value Types
//    typealias DataSource = UITableViewDiffableDataSource<Section, Ingredient>
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Ingredient>
    
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
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
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
    }
    
    func didTapClearButton() {
        searchViewModel.ingredients.removeAll()
        searchView.ingredientsTextField.text = ""
        
        // TODO: refresh snapshot
        ingredientsTableView.reloadData()
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
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let ingredient = searchViewModel.ingredients[indexPath.row]
        tableViewCell.textLabel?.text = ingredient
        
        return tableViewCell
    }
    
    private func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let index = indexPath.first!
            searchViewModel.deleteIngredient(index: index)
            
            tableView.deleteRows(at: [indexPath], with: .fade)

            tableView.endUpdates()
        }
    }
}
