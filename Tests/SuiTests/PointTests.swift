import XCTest
@testable import Sui
import Properties

class PointTests: XCTestCase {
  func testEquals() {
    XCTAssert(Point(2,3) == Point(2,3))
    XCTAssert(Point(3,3) != Point(2,3))
    XCTAssert(Point(2,4) != Point(2,3))
  }

  func testAdd() {
    XCTAssertEqual(Point(2,3) + Point(7,4), Point(9,7))
  }

  func testSubtract() {
    XCTAssertEqual(Point(9,7) - Point(2,3), Point(7,4))
  }

  func testMultiplyByAnInt() {
    XCTAssertEqual(Point(4,6)*2, Point(8,12))
  }

  func testMultiply() {
    XCTAssertEqual(Point(4,6)*Point(2,3), Point(8,18))
  }

  func testDivideByAnInt() {
    XCTAssertEqual(Point(4,6)/2, Point(2,3))
  }

  func testDivide() {
    XCTAssertEqual(Point(4,6)/Point(2,3), Point(2,2))
  }

  func testMax() {
    XCTAssertEqual(max(Point(2,6), Point(4,3)), Point(4,6))
  }

  func testMin() {
    XCTAssertEqual(min(Point(2,6), Point(4,3)), Point(2,3))
  }

  func testpivot() {
    XCTAssertEqual(Point(2,6).pivot(), Point(6,2))
  }
}
