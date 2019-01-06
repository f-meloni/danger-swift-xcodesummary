import Foundation

struct JSONFile {
    static func jsonObject(fromString string: String) -> [String:Any] {
        return (try! JSONSerialization.jsonObject(with: string.data(using: .utf8)!, options: .allowFragments)) as! [String:Any]
    }
}
