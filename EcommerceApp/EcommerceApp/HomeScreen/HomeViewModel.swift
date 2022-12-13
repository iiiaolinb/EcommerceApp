import UIKit
import Combine

protocol HomeViewModelProtocol {
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func configureSupplementaryView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView
    func loadImage(to imageView: UIImageView, from URLString: String, size: CGSize)
    func openBadConnectionScreen()
    func checkConnections(_ collectionView: UICollectionView)
    func goToFilterScreen()
    func goToDetailsScreen()
}

final class HomeViewModel: HomeViewModelProtocol {
    
    typealias Route = DetailsRoute & FilterRoute & BadConnectionRoute
    private let router: Route

    @Published var model: HomeModel?

    private var subscription: AnyCancellable? = nil
    
    var isFinished = false
    
    init(router: Route) {
        self.router = router
        makeFire()
    }
    
    func makeFire() {
        subscription = URLSession.shared.dataTaskPublisher(for: URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")!)
            .map { $0.data }
            .decode(type: HomeModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { value in
                switch value {
                case .failure(let error):
                    print("Finished with error \(error.localizedDescription)")
                    self.isFinished = false
                case .finished:
                    print("finished - Ok")
                    self.isFinished = true
                }
            }, receiveValue: { value in
                self.model = value
            })
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        
            //section 0 - cell for horizontal scroll view (HOT SALES)
            //section 1 - cell for vertical scroll view (BEST SELLER)
        if indexPath.section % 2 == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCell.cellId, for: indexPath) as? HotSalesCell else { return UICollectionViewCell() }
            
            let urlString = model?.home_store?[indexPath.row].picture ?? Constants.Default.whiteHilder
            asyncLoadImage(cell.letterLabel, urlString: urlString, size: sizeForItem(in: collectionView, items: 1))
            
            if let item = model?.home_store?[indexPath.row] {
                cell.itemsNameLabel.text = item.title
                cell.itemsSubtitleLabel.text = item.subtitle
                if let isNew = item.is_new { cell.newLabel.alpha = isNew ? 1 : 0 }
                if let isBuy = item.is_buy {
                    cell.buyButton.setTitle(isBuy ? "Buy now!" : "Sold out", for: .normal)
                    cell.buyButton.addTarget(self, action: #selector(goToDetailsScreen), for: .touchUpInside)
                }
            }
            return cell
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.cellId, for: indexPath) as? BestSellerCell else { return UICollectionViewCell() }

        let urlString = model?.best_seller?[indexPath.row].picture ?? Constants.Default.whiteHilder
        asyncLoadImage(cell.letterLabel, urlString: urlString, size: sizeForItem(in: collectionView, items: 2))
        
        if let item = model?.best_seller?[indexPath.row] {
            if let fullPrice = item.price_without_discount { cell.fullPrice.text = String("\(fullPrice) $") }
            cell.itemsName.text = item.title
            if let discountPrice = item.discount_price { cell.discountPrice.attributedText = NSAttributedString(string: String(discountPrice), attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]) }
            if let _ = item.is_favorites {
                cell.heartButton.setImage(UIImage(named: "HeartOrange"), for: .normal)
            } else {
                cell.heartButton.setImage(UIImage(named: "HeartOrangeBorder"), for: .normal)
            }
            cell.gestureButton.addTarget(self, action: #selector(goToDetailsScreen), for: .touchUpInside)
        }
        return cell
    }
    
    func configureSupplementaryView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: kind,
                                                                   for: indexPath)
        if let header = cell as? HeaderView { header.label.text = kind }
        
        return cell
    }
    
    func loadImage(to imageView: UIImageView, from URLString: String, size: CGSize) {
        asyncLoadImage(imageView, urlString: URLString, size: size)
    }
    
    func openBadConnectionScreen() {
        router.openBadConnectionScreen()
    }
    
    func checkConnections(_ collectionView: UICollectionView) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3),
                                      execute: {
            self.isFinished ? collectionView.reloadData() : self.openBadConnectionScreen()
        })
    }
    
    func goToFilterScreen() {
        isFinished ? router.openFilterScreen() : openBadConnectionScreen()
    }
    
    @objc func goToDetailsScreen() {
        router.openDetailsScreenWithTab()
    }
    
    private func sizeForItem(in collectionView: UICollectionView, items: CGFloat) -> CGSize {
        let sectionInsets = UIEdgeInsets(top: 6.0, left: 12.0, bottom: 6.0, right: 6.0)
        
        let paddingSpace = sectionInsets.left * items
        let availableWidth = collectionView.frame.width - paddingSpace
        let availableHeight = collectionView.frame.height - paddingSpace
        let widthPerItem = floor(availableWidth / items)
        let heightPerItem = floor(availableHeight / items)
        
        return CGSize(width: widthPerItem , height: items == 2 ? heightPerItem : heightPerItem/3)
    }
}
