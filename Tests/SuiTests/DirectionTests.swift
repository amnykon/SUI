import XCTest
@testable import Sui
import Properties

class DirectionTests: XCTestCase {
  func testIsVertical() {
    XCTAssert(Direction.up.isVertical)
    XCTAssert(Direction.down.isVertical)
    XCTAssert(!Direction.left.isVertical)
    XCTAssert(!Direction.right.isVertical)
  }

  func testIsHorizontal() {
    XCTAssert(!Direction.up.isHorizontal)
    XCTAssert(!Direction.down.isHorizontal)
    XCTAssert(Direction.left.isHorizontal)
    XCTAssert(Direction.right.isHorizontal)
  }

  func testIsBackwards() {
    XCTAssert(Direction.up.isBackwards)
    XCTAssert(!Direction.down.isBackwards)
    XCTAssert(Direction.left.isBackwards)
    XCTAssert(!Direction.right.isBackwards)
  }
}

