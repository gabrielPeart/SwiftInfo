import Foundation

public struct SwiftInfo {
    public let projectInfo: ProjectInfo
    public let fileUtils: FileUtils
    public let slackFormatter: SlackFormatter
    public let network: Network
    public let shell: Shell

    public init(projectInfo: ProjectInfo,
                fileUtils: FileUtils = .init(),
                slackFormatter: SlackFormatter = .init(),
                network: Network = Network.shared,
                shell: Shell = .init()) {
        self.projectInfo = projectInfo
        self.fileUtils = fileUtils
        self.slackFormatter = slackFormatter
        self.network = network
        self.shell = shell
    }

    public func extract<T: InfoProvider>(_ provider: T.Type) -> Output {
        do {
            log("Extracting \(provider.identifier)")
            let extracted = try provider.extract(fromApi: self)
            log("\(provider.identifier): Parsing previously extracted info", verbose: true)
            let other = try fileUtils.lastOutput.extractedInfo(ofType: provider)
            log("\(provider.identifier): Comparing with previously extracted info", verbose: true)
            let summary = extracted.summary(comparingWith: other)
            log("\(provider.identifier): Finishing", verbose: true)
            let info = ExtractedInfo(data: extracted, summary: summary)
            return try Output(info: info)
        } catch {
            fail(error.localizedDescription)
        }
    }

    public func sendToSlack(output: Output, webhookUrl: String) {
        log("Sending to Slack")
        log("Slack Webhook: \(webhookUrl)", verbose: true)
        let formatted = slackFormatter.format(output: output, projectInfo: projectInfo)
        network.syncPost(urlString: webhookUrl, json: formatted)
    }

    public func save(output: Output) {
        log("Saving output to disk")
        let outputFile = fileUtils.outputArray
        var dict = output.rawDictionary
        dict["swiftinfo_run_description_key"] = projectInfo.description
        do {
            try fileUtils.save(output: [dict] + outputFile)
        } catch {
            fail(error.localizedDescription)
        }
    }
}

public func fail(_ message: String) -> Never {
    log("Fatal error: \(message)")
    exit(-1)
}
