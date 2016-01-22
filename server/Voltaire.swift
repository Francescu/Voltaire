#if os(Linux)
import Glibc
#endif

import Foundation
import Swifter
import Mustache

struct Request {
    
    private init(swifterRequest: HttpRequest) {

    }
}


struct App {
    private let server = HttpServer()
    var staticPath: String {
        didSet {
            self.server["/static/:path"] = HttpHandlers.directory(staticPath) 
        }
    }

    var baseHTMLPath: String = "./" 

    init(staticPath: String = "./static/") {
       self.server["/static/:path"] = HttpHandlers.directory(staticPath) 
       self.staticPath = staticPath
    }

    func listen(port: UInt16 = 8080) {
        try! self.server.start(port)

        print("Server started at port \(port)")
        while true {
            sleep(1)
        }
    }
    typealias AppResponseHandler = (Request) -> String
    func get(path:String, handler: AppResponseHandler) {
        self.server[path] = { swifterRequest in
            let request = Request(swifterRequest: swifterRequest)
            let response = handler(request)
            return .OK(HttpResponseBody.Html(response))
       }
    }

}

extension App {
    func render(path: String, _ params: [String: String]) -> String {
        let template = try! Template(path: path)
        return try! template.render(Box(params))
    }
}
