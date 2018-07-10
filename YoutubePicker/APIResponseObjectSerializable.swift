
import Alamofire
import SwiftyJSON

public protocol ResponseObjectSerializable {
    init?(object: JSON)
}

public protocol ResponseCollectionSerializable {
    static func collection(object: JSON) -> [Self]
}
