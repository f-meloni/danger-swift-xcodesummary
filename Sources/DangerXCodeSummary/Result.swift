
struct Result: Equatable {
    let message: String
    let file: String?
    let line: Int?
    
    init(message: String) {
        self.message = message
        self.file = nil
        self.line = nil
    }
    
    init(message: String,
         file: String,
         line: Int?) {
        self.message = message
        self.file = file
        self.line = line
    }
}
