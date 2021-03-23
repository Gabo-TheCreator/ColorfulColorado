//
//  ColorfulColoradoNetworkingTest.swift
//  ColorfulColoradoTests
//
//  Created by Gabo Cuadros Cardenas on 3/23/21.
//

import XCTest
@testable import ColorfulColorado

extension ColorfulColoradoTests {
    
    func testURLCreation() {
        let router = Router.fetchColoradoImages
        guard let url = NetworkHelpers.createUrlFrom(router: router) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(url.absoluteString == "https://api.flickr.com/services/feeds/photos_public.gne?tags=coloradomountains&format=json&nojsoncallback=1")
    }
    
    func testNetworkResponseCanDecodeForRecentUploads() {
        let router = Router.fetchColoradoImages
        NetworkLayer<RecentUploads>.request(router: router) { (networkResponse) in
            switch networkResponse {
            case .success(let RecentUploadDataModel):
                XCTAssertNotNil(RecentUploadDataModel)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testDecodingForRecentUploads() {
        do {
            if let bundlePath = Bundle.main.path(forResource: "flickrDummyJson", ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                guard let parsedDataModel = NetworkLayer<RecentUploads>.decodeFrom(data: jsonData) else {
                    XCTFail()
                    return
                }
                XCTAssertNotNil(parsedDataModel)
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
