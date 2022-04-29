import UIKit

class SearchViewController: UIViewController {
    var searchViewModel = SearchViewModel()
    let searchView = SearchView()
    var ingredientList = MyIngredients()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reciplease"
        
        setupViews()
        setupLayout()
    }
    
    func setupViews() {
        searchView.delegate = self
        searchView.backgroundColor = .yellow
        view.addSubview(searchView)
    }
    
    func setupLayout() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func didTapSearchButton() {
        searchViewModel.searchRecipies(with: ["cheese"])
        let searchResultViewController = UIViewController()
        searchResultViewController.view.backgroundColor = .red
        navigationController?.pushViewController(searchResultViewController, animated: true)
    }
    
    func didTapAddButton() {
//        guard let ingredient = searchView.inTheFridge.text, !ingredient.isEmpty else {return}
//        ingredientList.listOfIngredients.append(ingredient)
//        
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didFindRecepies() {
        // todo refresh list of recipies
    }
    
    func didNotFindRecipe(error: Error) {
//        let alertVC = UIAlertController(title: "Error", message: ???????, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        present(alertVC, animated: true, completion: nil)
    }
}
