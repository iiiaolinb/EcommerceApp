import UIKit
import Combine

protocol DetailsViewModelProtocol {
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, sizeForItem: CGSize) -> UICollectionViewCell
    func isFavorite(_ heartButton: UIButton)
    func loadImage(to imageView: UIImageView, from URLString: String, size: CGSize)
    func addItemToCart(withColor color: String, capacity: String)
    func setColorOption1(first: UIButton, second: UIButton)
    func setColorOption2(second: UIButton, first: UIButton)
    func setCapacityOption1(first: UIButton, second: UIButton)
    func setCapacityOption2(second: UIButton, first: UIButton)
    func updateBadgeLabel(_ badge: UILabel, tabBar: UITabBarController?)
    func backToHomeScreen()
    func openCartScreen()
    func openBadConnectionScreen()
    func checkConnection(_ view: UIViewController)
}

final class DetailsViewModel: DetailsViewModelProtocol {
    
    typealias Route = CartRoute & HomeRoute & BadConnectionRoute
    private let router: Route
    
    @Published var model: DetailsModel?

    private var subscription: AnyCancellable? = nil
    private var favoriteToggle: Bool = false
    static var itemsInCart = CartModel.createEmptyModel()
    
    var isFinished = false
    
    init(router: Route) {
        self.router = router
        makeFire()
    }
    
    func makeFire() {
        subscription = URLSession.shared.dataTaskPublisher(for: URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5")!)
            .map { $0.data }
            .decode(type: DetailsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { value in
                switch value {
                case .failure(let error):
                    self.isFinished = false
                    print("Finished with error \(error.localizedDescription)")
                case .finished:
                    self.isFinished = true
                    print("Finished - Ok")
                }
            }, receiveValue: { value in
                self.model = value
            })
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, sizeForItem: CGSize) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.cellId, for: indexPath) as? GalleryCollectionViewCell,
              let imagesCount = model?.images?.count,
              let urlString = model?.images?[indexPath.row % imagesCount]
        else {
            return UICollectionViewCell()
        }
        loadImage(to: cell.imageView, from: urlString, size: sizeForItem)

        return cell
    }
    
    func isFavorite(_ heartButton: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            heartButton.backgroundColor = self.favoriteToggle ? Constants.Colors.orange : Constants.Colors.darkBlue
            self.favoriteToggle.toggle()
        } completion: { _ in }
    }
    
    func loadImage(to imageView: UIImageView, from URLString: String, size: CGSize) {
        asyncLoadImage(imageView, urlString: URLString, size: size)
    }
    
    func addItemToCart(withColor color: String, capacity: String) {
        isFinished ? sortAndAppend(item: (color: color, capacity: capacity)) : openBadConnectionScreen()
    }
    
        //the method sorts the added elements by color and memory
        //and adds them to the desired array
    private func sortAndAppend(item: (color: String, capacity: String)) {
        switch item {
        case (color: "#772D03", capacity: "126"):
            DetailsViewModel.itemsInCart[0].add(id: 0, title: model?.title, price: model?.price, capacity: item.capacity, color: item.color, image: model?.images?[1])
        case (color: "#772D03", capacity: "252"):
            DetailsViewModel.itemsInCart[1].add(id: 1, title: model?.title, price: model?.price, capacity: item.capacity, color: item.color, image: model?.images?[1])
        case (color: "#010035", capacity: "126"):
            DetailsViewModel.itemsInCart[2].add(id: 2, title: model?.title, price: model?.price, capacity: item.capacity, color: item.color, image: model?.images?[1])
        case (color: "#010035", capacity: "252"):
            DetailsViewModel.itemsInCart[3].add(id: 3, title: model?.title, price: model?.price, capacity: item.capacity, color: item.color, image: model?.images?[1])
        default:
            break
        }
    }
    
    func setColorOption1(first: UIButton, second: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            first.setImage(UIImage(named: "Select"), for: .normal)
            second.setImage(UIImage(), for: .normal)
        } completion: { _ in }
    }
    
    func setColorOption2(second: UIButton, first: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            second.setImage(UIImage(named: "Select"), for: .normal)
            first.setImage(UIImage(), for: .normal)
        } completion: { _ in }
    }
    
    func setCapacityOption1(first: UIButton, second: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            first.backgroundColor = Constants.Colors.orange
            first.setTitleColor(.white, for: .normal)
            second.backgroundColor = .clear
            second.setTitleColor(.lightGray, for: .normal)
        } completion: { _ in }
    }
    
    func setCapacityOption2(second: UIButton, first: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            second.backgroundColor = Constants.Colors.orange
            second.setTitleColor(.white, for: .normal)
            first.backgroundColor = .clear
            first.setTitleColor(.lightGray, for: .normal)
        } completion: { _ in }
    }
    
    func updateBadgeLabel(_ badge: UILabel, tabBar: UITabBarController?) {
        var count = 0
        DetailsViewModel.itemsInCart.forEach { count += $0.model.count }
        if count > 0 {
            badge.alpha = 1
            badge.text = String(count)
            tabBar?.tabBar.items?[1].badgeValue = String(count)
        } else {
            badge.alpha = 0
            tabBar?.tabBar.items?[1].badgeValue = nil
        }
    }
    
    func openCartScreen() { router.openCartScreen() }
    
    func openBadConnectionScreen() {
        makeFire()
        router.openBadConnectionScreen()
    }
    
    func backToHomeScreen() { router.goHome() }
    
    func checkConnection(_ view: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3),
                                      execute: {
            self.isFinished ? nil : self.openBadConnectionScreen()
        })
    }
}

