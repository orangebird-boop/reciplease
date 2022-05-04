import UIKit

class SearchViewController: UIViewController {

    var searchViewModel = SearchViewModel()
    let searchView = SearchView()
    let ingredientsTableView = UITableView()
   
    
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
        searchView.backgroundColor = .yellow
        view.addSubview(searchView)
        
        ingredientsTableView.backgroundColor = .clear
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        view.addSubview(ingredientsTableView)
    }
    
    func setupLayout() {
        [ingredientsTableView, searchView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchView.heightAnchor.constraint(equalToConstant: 128),
            
            ingredientsTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 16),
            ingredientsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            ingredientsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            ingredientsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func didTapSearchButton() {
        searchViewModel.searchRecipes(with: ["cheese"])
    }
    
    func didTapAddButton() {
        guard let ingredient = searchView.ingredientsTextField.text, !ingredient.isEmpty else {return}
        
        searchViewModel.add(ingredient: ingredient)
        
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didUpgradeIngredients() {
        ingredientsTableView.reloadData()
    }
    
    func didFindRecipes() {
        // TODO Display recipes
    }
    
    func didNotFindRecipe(error: Error) {
//        let alertVC = UIAlertController(title: "Error", message: ???????, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        present(alertVC, animated: true, completion: nil)
    }
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "test")
        let ingredient = searchViewModel.ingredients[indexPath.row]
        tableViewCell.textLabel?.text = ingredient
        
        return tableViewCell
    }
}

extension SearchViewController: UITableViewDelegate {
    
}
