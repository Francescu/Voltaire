import PackageDescription

let package = Package(
    name: "VoltaireExample",
    dependencies: [
        //.Package(url: "file:///Users/francescu/devel/tools/voltaire/", majorVersion: 0),
        .Package(url: "https://github.com/francescu/Voltaire", majorVersion: 0),
    ]
)
