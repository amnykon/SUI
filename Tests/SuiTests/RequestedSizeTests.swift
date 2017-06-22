import XCTest
@testable import Sui
import Properties

class RequestedSizeTests: XCTestCase {
  func testEquals() {
    XCTAssert(RequestedSize(Point(2,3)) == RequestedSize(Point(2,3)))
    XCTAssert(RequestedSize(Point(3,3)) != RequestedSize(Point(2,3)))
    XCTAssert(RequestedSize(Point(2,4)) != RequestedSize(Point(2,3)))
  }

  func testPivot() {
    XCTAssertEqual(
      RequestedSize(Point(2,4), moldable:Point(5,6)).pivot(),
      RequestedSize(Point(4,2), moldable:Point(6,5))
    )
  }
}
