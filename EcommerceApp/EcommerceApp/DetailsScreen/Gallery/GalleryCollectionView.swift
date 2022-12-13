import UIKit

class GalleryCollectionView: UICollectionView {
    
    private let itemsOnRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private var sizeForItem: CGSize = CGSize(width: Constants.Sizes.screenWidth / 2, height: Constants.Sizes.screenHeight * 4/10)
    private var viewModel: DetailsViewModel?
    
    init(viewModel: DetailsViewModel) {
        let layout = GalleryCollectionViewFlowLayout(itemSize: sizeForItem)
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        self.viewModel = viewModel
        
        backgroundColor = Constants.Colors.background
        
        delegate = self
        dataSource = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.cellId)
        
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GalleryCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (viewModel?.model?.images?.count ?? 0) * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        
        return viewModel.configureCell(collectionView: collectionView, indexPath: indexPath, sizeForItem: sizeForItem)
    }
}

extension GalleryCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        sizeForItem = sizeForItem(in: collectionView)
        return sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
      return sectionInsets.left
    }
    
    private func sizeForItem(in collectionView: UICollectionView) -> CGSize {
        
        let widthPaddingSpace = sectionInsets.left * (itemsOnRow)
        let heightPaddingSpace = sectionInsets.top
        let availableWidth = collectionView.frame.width - widthPaddingSpace
        let widthPerItem = floor(availableWidth / itemsOnRow)
        let availableHeight = collectionView.frame.height - heightPaddingSpace
        let heightPerItem = floor(availableHeight)

        return CGSize(width: widthPerItem , height: heightPerItem)
    }
}

extension GalleryCollectionView: UICollectionViewDelegate {
    
}
