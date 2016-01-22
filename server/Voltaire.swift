#if os(Linux)
import Glibc
#endif

import Foundation
import Swifter

struct Request {
    
    private init(swifterRequest: HttpRequest) {

    }
}

struct Response {

   func send(html: String) {
        
   }
}

struct App {
    private let server = HttpServer()
    let staticPath: String

    init(_ staticPath: String = "./static") {
        self.staticPath = staticPath

        self.server["/static/:path"] = HttpHandlers.directory(staticPath) 
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
            return .OK(HttpResponseBody.Html(handler(Request(swifterRequest:
                                swifterRequest))))
       }
    }

}
