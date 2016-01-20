#if os(Linux)
import Glibc
#endif

import Foundation
import Swifter

let server = HttpServer()

server["/public/:path"] = HttpHandlers.directory("../client/public/")
server["/"] = { request in
  return .OK(HttpResponseBody.Html("<img src='./public/swift.png' />")) 
}

try! server.start()

while true {
    sleep(1)
}

