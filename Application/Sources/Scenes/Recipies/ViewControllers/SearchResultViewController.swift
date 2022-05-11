import UIKit

class SearchResultViewController: UIViewController {
    
    let viewModel: SearchResultViewModel
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        return tableView
    }()
    
    var dataSource: UITableViewDiffableDataSource<Section, EdamamRecipe>!
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, EdamamRecipe>()
        snapshot.appendSections([.first])
       
    }
    enum Section {
        case first
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
////        tableView.dataSource = self // replace with diffabledatatsource
//        tableView.delegate = self
        tableView.delegate = self
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath)
            cell.textLabel?.text = model.label
            return cell
        })
        
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

// extension SearchResultViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.recipes.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else {
//            fatalError("This cell should be registerd")
//        }
//        
//        let recipe = viewModel.recipes[indexPath.row]
//        tableViewCell.configure(with: recipe)
//         
//        return tableViewCell
//    }
//}

extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.recipes[indexPath.row]
      
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
