import Foundation

struct HomeModel : Codable {
    let home_store : [HomeStore]?
    let best_seller : [BestSeller]?

    enum CodingKeys: String, CodingKey {
        case home_store = "home_store"
        case best_seller = "best_seller"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        home_store = try values.decodeIfPresent([HomeStore].self, forKey: .home_store)
        best_seller = try values.decodeIfPresent([BestSeller].self, forKey: .best_seller)
    }
}

struct HomeStore : Codable {
    let id : Int?
    let is_new : Bool?
    let title : String?
    let subtitle : String?
    let picture : String?
    let is_buy : Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case is_new = "is_new"
        case title = "title"
        case subtitle = "subtitle"
        case picture = "picture"
        case is_buy = "is_buy"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        is_new = try values.decodeIfPresent(Bool.self, forKey: .is_new)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
        is_buy = try values.decodeIfPresent(Bool.self, forKey: .is_buy)
    }
}

struct BestSeller : Codable {
    let id : Int?
    let is_favorites : Bool?
    let title : String?
    let price_without_discount : Int?
    let discount_price : Int?
    let picture : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case is_favorites = "is_favorites"
        case title = "title"
        case price_without_discount = "price_without_discount"
        case discount_price = "discount_price"
        case picture = "picture"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        is_favorites = try values.decodeIfPresent(Bool.self, forKey: .is_favorites)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price_without_discount = try values.decodeIfPresent(Int.self, forKey: .price_without_discount)
        discount_price = try values.decodeIfPresent(Int.self, forKey: .discount_price)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
    }
}
