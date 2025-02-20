import ArgumentParser
import Hummingbird

@main
struct HummingbirdArguments: ParsableCommand, AppArguments {
    @Option(name: .shortAndLong)
    var hostname: String = "127.0.0.1"

    @Option(name: .shortAndLong)
    var port: Int = 8080

    @Flag(name: .shortAndLong)
    var migrate: Bool = false

    @Flag(name: .shortAndLong)
    var inMemoryDatabase: Bool = false

    func run() throws {
        let app = HBApplication(
            configuration: .init(
                address: .hostname(self.hostname, port: self.port),
                serverName: "Hummingbird"
            )
        )
        try app.configure(self)
        if self.migrate {
            try app.fluent.migrate().wait()
        }
        try app.start()
        app.wait()
    }
}
