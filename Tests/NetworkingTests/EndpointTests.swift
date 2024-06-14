import Testing
@testable import Networking

struct EndpointTests {
    @Test
    func buildRequest() async throws {
        let getEndpoint = MockEndpoint(path: "/path",
                                    method: .GET,
                                    headers: ["testHeaderKey" : "testHeaderValue"],
                                    parameters: ["testParameterKey": "testParameterValue"])
        let getRequest = try getEndpoint.buildRequest(with: "http://test")

        #expect(getRequest.url?.absoluteString.components(separatedBy: "?").first == "http://test/path")
        #expect(getRequest.httpMethod == HTTPMethod.GET.rawValue)
        #expect(getRequest.allHTTPHeaderFields?["testHeaderKey"] == "testHeaderValue")
        #expect(
            getRequest.url?.query?
                .components(separatedBy: "&")
                .first(where: { $0.contains("testParameterKey=testParameterValue") })
            != nil
        )

        no parameters

        post

        post request with query parameters
    }
}
