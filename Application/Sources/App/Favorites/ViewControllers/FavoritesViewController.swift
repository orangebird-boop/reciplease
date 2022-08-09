import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDelegate {

    var viewModel = FavoritesViewModel()
    let defaultImage = UIImage(named: "defaultForkKnifeSpoon")
    
    init(model: FavoritesViewModel) {
        self.viewModel = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:}) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        return tableView
    }()
    
//    private lazy var dataSource = makeDataSource()
//
//    enum Section {
//        case first
//    }
//
//    typealias DataSource = UITableViewDiffableDataSource<Section, Recipe>
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>
//
//    func applySnapshot(animatingDifferences: Bool = true) {
//        var snapshot = Snapshot()
//
//        snapshot.appendSections([.first])
//
//        snapshot.appendItems(viewModel.favoriteRecipes)
//
//        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
//    }

        // should be in view model
        
//        snapshot.appendItems(viewModel.recipes)
        
//    func fetchFavourites() {
//        do {
//            self.items = try context.fetch(RecipeEntity.fetchRequest())
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        } catch {
//
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margins.medium),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Margins.medium),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Margins.medium),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margins.medium)
        ])
//        applySnapshot()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//      super.viewWillAppear(animated)
//
//      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//        return
//      }
//
//      let managedContext = appDelegate.persistentContainer.viewContext
//      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RecipeEntity")
//
//      do {
//        favorites = try managedContext.fetch(fetchRequest)
//      } catch let error as NSError {
//        print("Could not fetch. \(error), \(error.userInfo)")
//      }
//    }

//    func makeDataSource() -> DataSource {
//        DataSource(tableView: tableView) { tableView, indexPath, model in
//            guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else {
//                fatalError("This cell should be registerd")
//            }
//
//            tableViewCell.configure(with: model)
//
//            return tableViewCell
//        }
//    }
//
}
extension FavoritesViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.recipes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      let recipe = viewModel.recipes[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      cell.textLabel?.text = recipe.name// (forKeyPath: "name") as? String
    return cell
  }
}

// extension FavoritesViewController: UITableViewDelegate {
//   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 260.0 // Choose your custom row height
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let recipe = dataSource.itemIdentifier(for: indexPath) else {
//            return
//        }
//
//        let viewController = FavoritesDetailsViewController(viewModel: FavouritesDetailsViewModel(recipe: recipe))
//
//                navigationController?.pushViewController(viewController, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true )
//    }
// }
