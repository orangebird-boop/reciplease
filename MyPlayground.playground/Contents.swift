import UIKit
func descendingOrder(of number: Int) -> Int {
    
    let string = String(number)
  var digits = string.compactMap{ $0.wholeNumberValue }
    digits.sort(by: >)
    let numberInOrder = digits.reduce(0, {$0*10 + $1})
    return numberInOrder
}
