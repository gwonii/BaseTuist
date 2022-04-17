import ProjectDescription

// MARK: - Project
func makeFrameworkTargets(
    name: String,
    product: Product = .framework,
    platform: Platform,
    dependencies: [TargetDependency]
) -> [Target] {
    let sources = Target(
        name: name,
        platform: platform,
        product: .framework,
        bundleId: "com.gmail.hc.gwonii.\(name)",
        deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone, .ipad]),
        infoPlist: .default,
        sources: ["Targets/\(name)/Sources/**"],
        resources: [],
        dependencies: dependencies
    )
//    let tests = Target(
//        name: "\(name)Tests",
//        platform: platform,
//        product: .unitTests,
//        bundleId: "com.gmail.hc.gwonii.\(name)Tests",
//        infoPlist: .default,
//        sources: ["Targets/\(name)/Tests/**"],
//        resources: [],
//        dependencies: [.target(name: name)]
//    )
    return [sources]
}

func makeAppTargets(
    name: String,
    platform: Platform,
    dependencies: [TargetDependency]
) -> [Target] {
    let mainTarget = Target(
        name: name,
        platform: platform,
        product: .app,
        bundleId: "${BUNDLE_IDENTIFIER}",
        deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone, .ipad]),
        infoPlist: .default,
        sources: ["Targets/\(name)/Sources/**"],
        resources: ["Targets/\(name)/Resources/**"],
//        entitlements: .relativeToCurrentFile("Targets/DaouESS/Resources/DaouESS.entitlements"),
        dependencies: dependencies
    )
    return [mainTarget]
}

let project: Project = .init(
    // TODO: Should edit name
    name: "Base",
    organizationName: "Hogwon CHOI",
    settings: .settings(
        base: SettingsDictionary()
                .automaticCodeSigning(devTeam: "FJHLD62USU"),
        configurations: [
            .debug(
                name: "Debug",
                settings: [
                    // TODO: Should edit BundleID
                    "BUNDLE_IDENTIFIER": "com.gmail.hc.gwonii.base-dev",
                    "DISPLAY_NAME": "base-dev"
                ]
            ),
            .release(
                name: "Release",
                settings: [
                    // TODO: Should edit BundleID
                    "BUNDLE_IDENTIFIER": "com.gmail.hc.gwonii.base",
                    "DISPLAY_NAME": "base"
                ]
            )
        ]
    ),
    targets: [
        makeAppTargets(name: "base", platform: .iOS, dependencies: [
            .target(name: "Presentation")
        ]),
        makeFrameworkTargets(name: "Core", platform: .iOS, dependencies: [
            
        ]),
        makeFrameworkTargets(name: "Data", product: .framework, platform: .iOS, dependencies: [
            .target(name: "Domain")
        ]),
        makeFrameworkTargets(name: "Domain", product: .framework, platform: .iOS, dependencies: [
            
        ]),
        makeFrameworkTargets(name: "Presentation", product: .framework, platform: .iOS, dependencies: [
            .target(name: "Domain")
        ])
    ].flatMap({ $0 })
)
