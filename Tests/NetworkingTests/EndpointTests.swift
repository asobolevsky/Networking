import Testing
import Foundation
@testable import Networking

struct EndpointTests {
    @Test
    func buildrequestWithParams() async throws {
        let ndpoint = MockEndpoint(path: "/path",
                                   method: .GET,
                                   headers: ["testHeaderKey" : "testHeaderValue"],
                                   parameters: ["testParameterKey": "testParameterValue"])
        let request = try ndpoint.buildRequest(with: "http://test")

        #expect(request.url?.absoluteString.components(separatedBy: "?").first == "http://test/path")
        #expect(request.httpMethod == HTTPMethod.GET.rawValue)
        #expect(request.allHTTPHeaderFields?["testHeaderKey"] == "testHeaderValue")
        #expect(
            request.url?.query?
                .components(separatedBy: "&")
                .first(where: { $0.contains("testParameterKey=testParameterValue") })
            != nil
        )
    }

    @Test
    func buildrequestWithNoParams() async throws {
        let ndpoint = MockEndpoint(path: "/path",
                                   method: .GET,
                                   headers: ["testHeaderKey" : "testHeaderValue"])
        let request = try ndpoint.buildRequest(with: "http://test")

        #expect(request.url?.absoluteString == "http://test/path")
        #expect(request.httpMethod == HTTPMethod.GET.rawValue)
        #expect(request.allHTTPHeaderFields?["testHeaderKey"] == "testHeaderValue")
    }

    @Test
    func buildPostRequestWithNoQuery() async throws {
        let ndpoint = MockEndpoint(path: "/path",
                                   method: .POST,
                                   headers: ["testHeaderKey" : "testHeaderValue"],
                                   parameters: ["testParameterKey": "testParameterValue"])
        let request = try ndpoint.buildRequest(with: "http://test")

        #expect(request.url?.absoluteString == "http://test/path")
        #expect(request.httpMethod == HTTPMethod.POST.rawValue)
        #expect(request.allHTTPHeaderFields?["testHeaderKey"] == "testHeaderValue")
        #expect(request.httpBody != nil)


        let jsonBody = try JSONSerialization.jsonObject(with: request.httpBody!, options: []) as! [String: String]
        #expect(jsonBody["testParameterKey"] == "testParameterValue")
    }

    @Test
    func buildPostRequestWithQuery() async throws {
        let ndpoint = MockEndpoint(path: "/path",
                                   method: .POST,
                                   headers: ["testHeaderKey" : "testHeaderValue"],
                                   parameters: ["testParameterKey": "testParameterValue"])
        let request = try ndpoint.buildRequest(with: "http://test")

        #expect(request.url?.absoluteString == "http://test/path")
        #expect(request.httpMethod == HTTPMethod.POST.rawValue)
        #expect(request.allHTTPHeaderFields?["testHeaderKey"] == "testHeaderValue")
        #expect(request.httpBody != nil)


        let jsonBody = try JSONSerialization.jsonObject(with: request.httpBody!, options: []) as! [String: String]
        #expect(jsonBody["testParameterKey"] == "testParameterValue")
    }
}
