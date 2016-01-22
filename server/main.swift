import Foundation

let app = App("./client/public/")
    
app.get("hello") { request in 

    return "<h1>test</h1><img src=\"/static/swift.png\" />"
}

app.listen()

