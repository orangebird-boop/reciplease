import UIKit

class SearchResultViewController: UIViewController {
    
    let viewModel: SearchResultViewModel
    weak var tableView: UITableView!
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultTableViewCell")
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as! SearchResultTableViewCell
//        guard let cell = tableViewCell else {
//            return ???? UITableViewCell()
//        }
//
        let recipe = viewModel.recipes[indexPath.row]
        tableViewCell.configure(with: recipe.label)
        tableViewCell.delegate = self
//        tableViewCell.textLabel?.text = recipe.label
        
        return tableViewCell
    }
}

extension SearchResultViewController: SearchResultTableViewCellDelegate {
    func didTapButton(with title: String) {
        print(title)
    }
}
