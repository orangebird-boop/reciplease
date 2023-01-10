import Foundation

class MockURLProtocol: URLProtocol {
	
	static var mockData: Data?
	
	override class func canInit(with request: URLRequest) -> Bool {
		true
	}
	
	override class func canInit(with task: URLSessionTask) -> Bool {
		true
	}
	
	override func stopLoading() {
		
	}
	
	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		request
	}
	
	override func startLoading() {
		guard let mockData = Self.mockData else { return }
		
		client?.urlProtocol(self, didLoad: mockData)
		client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
		client?.urlProtocolDidFinishLoading(self)
	}
}
