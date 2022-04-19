import UIKit

class FavouritesViewController: UIViewController {
    weak var tableView: UITableView!
    
    let favouritesView = FavouritesView()
    let tableVIew = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reciplease"
        
        setupViews()
        setupLayout()
    }
    
    func setupViews() {
        view.addSubview(tableView)
        
//        favouritesView.backgroundColor = .green
//        view.addSubview(favouritesView)
    }
    
    func setupLayout() {
        tableVIew.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableView.topAnchor),
                       self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
                       self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
                       self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
            
//            favouritesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            favouritesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            favouritesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            favouritesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        self.tableView = tableVIew
    }
}
