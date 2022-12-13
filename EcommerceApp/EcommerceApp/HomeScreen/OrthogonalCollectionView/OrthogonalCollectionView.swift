import UIKit

final class OrthogonalCollectionView: UICollectionView {
    
    private var viewModel: HomeViewModel?
    
    lazy var refreshController: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTable), for: .allEvents)
        return refresh
    }()

    init(viewModel: HomeViewModel , frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        self.viewModel = viewModel
        
        backgroundColor = Constants.Colors.background
        
        delegate = self
        dataSource = self
        
        register(BestSellerCell.self, forCellWithReuseIdentifier: BestSellerCell.cellId)
        register(HotSalesCell.self, forCellWithReuseIdentifier: HotSalesCell.cellId)
        
        register(
            HeaderView.self,
            forSupplementaryViewOfKind: SupplementaryElements.collectionHeader,
            withReuseIdentifier: SupplementaryElements.collectionHeader
        )
        
        register(
            HeaderView.self,
            forSupplementaryViewOfKind: SupplementaryElements.sectionHeader,
            withReuseIdentifier: SupplementaryElements.sectionHeader
        )

        register(
            Spacer.self,
            forSupplementaryViewOfKind: SupplementaryElements.sectionSpacer,
            withReuseIdentifier: SupplementaryElements.sectionSpacer
        )
        
        addSubview(refreshController)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onBuyButton() {
        viewModel?.goToDetailsScreen()
    }
    
    @objc private func refreshTable() {
        self.reloadData()
        viewModel?.makeFire()
        refreshController.endRefreshing()
    }
}

extension OrthogonalCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            //section 0 - horizontal scroll view (HOT SALES)
            //section 1 - vertical scroll view (BEST SELLER)
        if section % 2 == 0 {
            return viewModel?.model?.home_store?.count ?? 1
        }
        return viewModel?.model?.best_seller?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        return viewModel.configureCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let viewModel = viewModel else { return UICollectionReusableView() }
        return viewModel.configureSupplementaryView(collectionView: collectionView, kind: kind, indexPath: indexPath)
    }
}

extension OrthogonalCollectionView: UICollectionViewDelegate {
    
}

