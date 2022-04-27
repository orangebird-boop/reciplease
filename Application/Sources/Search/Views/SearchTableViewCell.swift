import UIKit

class SerachTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            self.initialize()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)

            self.initialize()
        }

        func initialize() {
// ??
        }
    
        override func prepareForReuse() {
            super.prepareForReuse()

        }
}
