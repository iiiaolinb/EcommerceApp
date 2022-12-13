import UIKit

enum SupplementaryElements {
    static let collectionHeader = "Hot sales"
    static let sectionHeader = "Best Seller"
    static let sectionSpacer = "sectionSpacer"
}

enum GridCompositionalLayout {
    static func generateLayout() -> UICollectionViewCompositionalLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.boundarySupplementaryItems = [makeCollectionHeader()]
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: { section, _ in
                
                if section % 2 == 0 {
                    return makeHorizontalSection()
                }
                return makeVerticalSection()
            },
            configuration: config
        )
    }
    
    private static func makeItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                              heightDimension: .fractionalHeight(0.95)))
        
        item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        return item
    }
    
    private static func makeGroup() -> NSCollectionLayoutGroup {
        let group =  NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(0.6)),
            subitems: [makeItem()]
        )
        
        group.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        return group
    }
    
    private static func makeSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(60)),
            elementKind: SupplementaryElements.sectionHeader,
            alignment: .topLeading
        )
    }
    
    private static func makeCollectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(60)),
            elementKind: SupplementaryElements.collectionHeader,
            alignment: .top
        )
    }
    
    private static func makeSpacer() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(60)),
            elementKind: SupplementaryElements.sectionSpacer,
            alignment: .top
        )
    }
    
    private static func makeVerticalSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: makeGroup())
        section.contentInsets = .init(top: 16,
                                      leading: 0,
                                      bottom: 0,
                                      trailing: 0)
        section.boundarySupplementaryItems = [makeSpacer(), makeSectionHeader()]
        
        return section
    }
}

extension GridCompositionalLayout {
    
    private static func makeHorizontalItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = .init(top: 1, leading: 1, bottom: 1, trailing: 1)
        return item
    }
    
    private static func makeHorizontalGroup() -> NSCollectionLayoutGroup {
        let group =  NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .fractionalHeight(0.3)),
            subitems: [makeHorizontalItem()]
        )
        
        return group
    }
    
    private static func makeHorizontalSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: makeHorizontalGroup())
        section.contentInsets = .init(top: 16,
                                      leading: 0,
                                      bottom: 0,
                                      trailing: 0)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section

    }
    
}
