import UIKit

final class FilterViewModel {
    var filterModel = [
        FilterModel(header: "Brand", items: [], isTapped: false),
        FilterModel(header: "Select", items: ["Samsung", "Iphone", "Xiaomi"], isTapped: false),
        FilterModel(header: "Price", items: [], isTapped: false),
        FilterModel(header: "Select", items: ["$100 - $500", "$500 - $1000", "$1000 - $5000", "$5000 - $10000"], isTapped: false),
        FilterModel(header: "Size", items: [], isTapped: false),
        FilterModel(header: "Select", items: ["4.5 - 5.5 inches", "5.5 - 6.5 inches", "6.5 - 7.5 inches"], isTapped: false)
        ]
}
