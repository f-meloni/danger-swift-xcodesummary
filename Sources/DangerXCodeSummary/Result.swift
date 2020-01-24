
public struct Result: Equatable, Hashable {
    public enum Category {
        case warning, error, message
    }

    public let message: String
    public let file: String?
    public let line: Int?
    public let category: Category
    
    init(message: String, category: Category) {
        self.message = message
        self.file = nil
        self.line = nil
        self.category = category
    }
    
    init(message: String,
         file: String,
         line: Int?,
         category: Category) {
        self.message = message
        self.file = file
        self.line = line
        self.category = category
    }
}
