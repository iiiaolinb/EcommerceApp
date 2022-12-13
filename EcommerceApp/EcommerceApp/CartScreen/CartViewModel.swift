import UIKit
import Combine

enum ChangeType {
    case plus, minus
}

protocol CartViewModelProtocol {
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func loadImage(to imageView: UIImageView, from URLString: String, size: CGSize)
    func backToDetailsScreen()
    func openConfirmationScreen(tableView: UITableView, forIndexPath indexPath: IndexPath)
}

final class CartViewModel: CartViewModelProtocol {
    typealias Route = CartRoute & DetailsRoute & ConfirmationRoute
    private let router: Route
    
    init(router: Route) {
        self.router = router
    }
    
        //for cellForRowAtIndexPath in tableView
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.cellId, for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        
        cell.itemsName.text = configureInfo(indexPath: indexPath).name
        cell.itemsCost.text = configureInfo(indexPath: indexPath).price
        cell.countLabel.text = configureInfo(indexPath: indexPath).count
        
        asyncLoadImage(cell.itemImageView,
                       urlString: configureInfo(indexPath: indexPath).imageURL ,
                       size: CGSize(width: Constants.Sizes.imageInCartSizes.width * 3/4,
                                    height: Constants.Sizes.imageInCartSizes.height))
        cell.plusButton.tag = CartViewModel.associatedArray()[indexPath.row] ?? 0
        cell.minusButton.tag = CartViewModel.associatedArray()[indexPath.row] ?? 0
        cell.selectionStyle = .none
        
        return cell
    }
    
        //configure cell assistent
    private func configureInfo(indexPath: IndexPath) -> (name: String?, price: String, imageURL: String, count: String?) {
        
        var imageURL = ""
        var itemsPrice = 0
        let associatedArray = CartViewModel.associatedArray()
        
        let itemsName = DetailsViewModel.itemsInCart[associatedArray[indexPath.row] ?? 0].model.first?.title
        if let priceOfItem = DetailsViewModel.itemsInCart[associatedArray[indexPath.row] ?? 0].model.first?.price { itemsPrice = priceOfItem }
        if let imageURLString = DetailsViewModel.itemsInCart[associatedArray[indexPath.row] ?? 0].model.first?.image { imageURL = imageURLString }
        let numberOfItemsInRow = numberOfItemsInRow(id: associatedArray[indexPath.row] ?? 0)
        
        return (itemsName, String("$\(itemsPrice).00"), imageURL, numberOfItemsInRow)
    }
    
        //the method returns the amount to be paid
    static func calculateTotalPrice() -> String {
        var total = 0
        DetailsViewModel.itemsInCart.forEach { $0.model.forEach { total += $0.price ?? 0 } }
        return String("$\(total.formattedWithSeparator) us")
    }
    
        //the method adds or removes elements from the array
    static func changeCount(_ changeType: ChangeType, buttonTag: Int) -> String {
        
        guard let items = DetailsViewModel.itemsInCart.filter({ $0.id == abs(buttonTag) }).first else { return "" }
        
        switch changeType {
        case .plus:
            DetailsViewModel.itemsInCart[buttonTag].model.append(Model(title: items.model.first?.title, price: items.model.first?.price, capacity: items.model.first?.capacity, color: items.model.first?.color, image: items.model.first?.image))
            return  String(items.model.count + 1)
        case .minus:
            if items.model.count > 1 {
                DetailsViewModel.itemsInCart[buttonTag].model.removeFirst()
                return  String(items.model.count - 1)
            }
            return String(items.model.count)
        }
    }
    
        //for numberOfRowsInSection in tableView
    func numberOfRowsInSection() -> Int {

        return DetailsViewModel.itemsInCart.filter { $0.model.count != 0 }.count
    }
    
        //delete row
    static func deleteRowInSection(tableView: UITableView, indexPath: IndexPath) {
        DetailsViewModel.itemsInCart[associatedArray()[indexPath.row] ?? 0].model.removeAll()
        tableView.deleteRows(at: [indexPath], with: .fade)
        CartViewController.updateUI()
    }
    
        //the method returns the number of items by id
    func numberOfItemsInRow(id: Int) -> String {

        return String(DetailsViewModel.itemsInCart[id].model.count)
    }
    
        //the array associates the cell number and the id number
        //of the added item
    static func associatedArray() -> [Int : Int] {
        var associatedArray = [Int : Int]()
        var count = 0
        DetailsViewModel.itemsInCart.forEach { values in
            if values.model.count != 0 {
                associatedArray[count] = values.id
                count += 1
            }
        }
        return associatedArray
    }
    
    func loadImage(to imageView: UIImageView, from URLString: String, size: CGSize) {
        asyncLoadImage(imageView, urlString: URLString, size: size)
    }
    
    func backToDetailsScreen() {
        router.openDetailsScreenWithNavigation()
    }
    
    func openConfirmationScreen(tableView: UITableView, forIndexPath indexPath: IndexPath) {
        router.openConfirmationScreen(tableView: tableView, forIndexPath: indexPath)
    }
}
