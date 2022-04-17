import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init(
        [
            // TODO: Add library used in your project
//            .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMinor(from: "5.5.0"))
        ]
    ),
    platforms: [.iOS]
)

