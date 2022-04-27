import Foundation
import UIKit

class SearchTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    var ingredientList = MyIngredients()
    let tableView = UITableView()
    let dataSource = MyIngredientsDataSource()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList.listOfIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath as IndexPath)
    
        cell.textLabel?.text = ingredientList.listOfIngredients[indexPath.row]
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(SerachTableViewCell.self, forCellReuseIdentifier: "CellId")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
