import UIKit

struct CartModel {
    var id: Int
    var model: [Model]
    
    mutating func add(id: Int, title: String?, price: Int?, capacity: String?, color: String?, image: String?) {
        self.id = id
        self.model.append(Model(title: title, price: price, capacity: capacity, color: color, image: image))
    }
    
    mutating func remove() {
        self.model.removeLast()
    }
    
    static func createEmptyModel() -> [CartModel] {
        return [CartModel(id: 0, model: [Model]()),
                CartModel(id: 1, model: [Model]()),
                CartModel(id: 2, model: [Model]()),
                CartModel(id: 3, model: [Model]())
        ]
    }
}

struct Model {
    var title: String?
    var price: Int?
    var capacity: String?
    var color: String?
    var image: String?
}



