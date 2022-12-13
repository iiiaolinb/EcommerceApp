import UIKit

class CategoryCollectionView: UICollectionView {
    
    private let viewModel = CategoryViewModel()
    
    private let itemsOnRow: CGFloat = 4
    private let sectionInsets = UIEdgeInsets(top: 24.0, left: 24.0, bottom: 36.0, right: 24.0)
    private var sizeForItem: CGSize = CGSize(width: Constants.Sizes.screenWidth / 4, height: Constants.Sizes.screenHeight * 1/10)
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .clear
        
        delegate = self
        dataSource = self
        register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.cellId)
        
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sizeForItem(in collectionView: UICollectionView) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsOnRow)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = floor(availableWidth / itemsOnRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

extension CategoryCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.cellId, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = UIImage(named: viewModel.list[indexPath.item])
        cell.titleLabel.text = viewModel.list[indexPath.item]
        
        return cell
    }
}

extension CategoryCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return sizeForItem(in: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
      return sectionInsets.left
    }
}

extension CategoryCollectionView: UICollectionViewDelegate {
    
}
