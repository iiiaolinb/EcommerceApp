import UIKit

struct DetailsModel: Decodable {
    let cPU : String?
    let camera : String?
    let capacity : [String]?
    let color : [String]?
    let id : String?
    var images : [String]?
    let isFavorites : Bool?
    let price : Int?
    let rating : Double?
    let sd : String?
    let ssd : String?
    let title : String?

    enum CodingKeys: String, CodingKey {
        case cPU = "CPU"
        case camera = "camera"
        case capacity = "capacity"
        case color = "color"
        case id = "id"
        case images = "images"
        case isFavorites = "isFavorites"
        case price = "price"
        case rating = "rating"
        case sd = "sd"
        case ssd = "ssd"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cPU = try values.decodeIfPresent(String.self, forKey: .cPU)
        camera = try values.decodeIfPresent(String.self, forKey: .camera)
        capacity = try values.decodeIfPresent([String].self, forKey: .capacity)
        color = try values.decodeIfPresent([String].self, forKey: .color)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        isFavorites = try values.decodeIfPresent(Bool.self, forKey: .isFavorites)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        sd = try values.decodeIfPresent(String.self, forKey: .sd)
        ssd = try values.decodeIfPresent(String.self, forKey: .ssd)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
    
    init(cPu: String?, camera: String?, capacity: [String]?, color: [String]?, id: String?, images: [String]?, isFavorite: Bool?, price: Int?, rating: Double?, sd: String?, ssd: String?, title: String?) {
        self.cPU = cPu
        self.camera = camera
        self.capacity = capacity
        self.color = color
        self.id = id
        self.images = images
        self.isFavorites = isFavorite
        self.price = price
        self.rating = rating
        self.sd = sd
        self.ssd = ssd
        self.title = title
        
    }
}
