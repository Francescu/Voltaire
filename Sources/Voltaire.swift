#if os(Linux)
import Glibc
#endif

import Foundation
import Swifter
import Mustache

public struct Request {
    
    private init(swifterRequest: HttpRequest) {

    }
}


public struct App {
    private let server = HttpServer()
    public let staticPath: String 

    var baseHTMLPath: String = "./" 

    public init(staticPath: String = "./static/") {
       self.server["/static/:path"] = HttpHandlers.directory(staticPath) 
       self.staticPath = staticPath
    }

    public func listen(port: UInt16 = 8080) {
        try! self.server.start(port)

        print("Server started at port \(port)")
        while true {
            sleep(1)
        }
    }

    public typealias AppResponseHandler = (Request) -> String
    public func get(path:String, handler: AppResponseHandler) {
        self.server[path] = { swifterRequest in
            let request = Request(swifterRequest: swifterRequest)
            let response = handler(request)
            return .OK(HttpResponseBody.Html(response))
       }
    }

}

extension App {
    public func render(path: String, _ params: [String: String]) -> String {
        let template = try! Template(path: path)
        return try! template.render(Box(params))
    }
}
