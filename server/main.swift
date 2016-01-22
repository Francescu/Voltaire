import Foundation
import Voltaire

let app = App(staticPath: "./client/public/")

app.get("hello") { request in 
    return app.render("client/index.html", ["image" : "swift"])
}

app.listen()

