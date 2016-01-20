import Foundation
import Swifter

let server = HttpServer()

server["/public/:path"] = HttpHandlers.directory("../client/public/")
server["/hello"] = { .OK(HttpResponseBody.Html("You asked for " + $0.path)) }

try! server.start()

    while true {
        sleep(1)
    }

