import Foundation
import UIKit

class SearchViewController: UIViewController {
    let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reciplease"
        
        setupViews()
        setupLayout()
    }
    
    func setupViews() {
        searchView.delegate = self
        searchView.backgroundColor = .white
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
        let searchResultsVC = UIViewController()
        searchResultsVC.view.backgroundColor = .red
        navigationController?.pushViewController(searchResultsVC, animated: true)
    }
}
