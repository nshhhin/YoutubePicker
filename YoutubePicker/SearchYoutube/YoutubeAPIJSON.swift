
import Foundation
import PromiseKit
import ObjectMapper
import Alamofire

final class YoutubeAPIJSON {
    
    static let shared = YoutubeAPIJSON()
    
    func request( apiKey: String, keyword: String) -> Promise<String> {
        let url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=" + keyword + "&key=" + apiKey + "&maxResults=50&type=video"

        return Promise { seal in
            Alamofire.request(url).responseString { response in
                switch response.result {
                    case .success(let data):
                        seal.fulfill(data)
                    case .failure:
                        seal.reject(InternalError.loadFileFailed)
                }
            }
        }
    }
    
    func mapping(jsonStr: String) -> Promise<Results> {
        return Promise { seal in
            guard let results = Mapper<Results>().map(JSONString: jsonStr) else {
                return seal.reject(InternalError.mapFailed)
            }
            seal.fulfill(results)
        }
    }
}

enum InternalError: Error {
    case mapFailed
    case loadFileFailed
}

struct Results: Mappable {
    
    var results: [Result]?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        results <- map["items"]
    }
}

struct Result: Mappable {
    var vid = ""
    var title = ""
    var thumbnail = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        vid <- map["id.videoId"]
        title <- map["snippet.title"]
        thumbnail <- map["snippet.thumbnails.high.url"]
    }
    
}
