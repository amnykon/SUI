import XCTest
@testable import Sui
import Properties

class StackLayoutTests: XCTestCase {
  let widgetType=WidgetType(parent:anyWidgetType)
  var widget=Widget(type:anyWidgetType)
  var child1=Widget(type:anyWidgetType)
  var child2=Widget(type:anyWidgetType)

  override func setUp() {
    super.setUp()

    widget=Widget(type:widgetType)
    child1=Widget(type:widgetType)
    child2=Widget(type:widgetType)
    child1.container=widget
    child2.container=widget

 }

  func testGetRequestedSizeWithADirectionOfLeft() {
    widget.style=Style(
      widgetType <- [
        layoutProperty <- StackLayout(),
        primaryLayoutDirectionProperty <- .left,
      ],

      (widgetType / widgetType) <- [
         layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )

    XCTAssertEqual(widget.requestedSize, RequestedSize(Point(2,2), moldable:Point(2,1)))
  }

  func testGetAllocatedSpaceWithADirectionOfLeft() {
    widget.style=Style(
      widgetType <- [
        layoutProperty <- StackLayout(),
        primaryLayoutDirectionProperty <- .left,
      ],

      (widgetType / widgetType) <- [
         layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )

    XCTAssertEqual(child1.allocatedSpace, AllocatedSpace(Point(1,0), Point(1,2)))
    XCTAssertEqual(child2.allocatedSpace, AllocatedSpace(Point(0,0), Point(1,2)))
  }

  func testGetRequestedSizeWithADirectionOfRight() {
    widget.style=Style(
      widgetType <- [
        layoutProperty <- StackLayout(),
        primaryLayoutDirectionProperty <- .right,
      ],

      (widgetType / widgetType) <- [
         layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )

    XCTAssertEqual(widget.requestedSize, RequestedSize(Point(2,2), moldable:Point(2,1)))
  }

  func testGetAllocatedSpaceWithADirectionOfRight() {
    widget.style=Style(
      widgetType <- [
        layoutProperty <- StackLayout(),
        primaryLayoutDirectionProperty <- .right,
      ],

      (widgetType / widgetType) <- [
         layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )

    XCTAssertEqual(child1.allocatedSpace, AllocatedSpace(Point(0,0), Point(1,2)))
    XCTAssertEqual(child2.allocatedSpace, AllocatedSpace(Point(1,0), Point(1,2)))
  }

  func testGetRequestedSizeWithADirectionOfUp() {
    widget.style=Style(
      widgetType <- [
        layoutProperty <- StackLayout(),
        primaryLayoutDirectionProperty <- .up,
      ],

      (widgetType / widgetType) <- [
         layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )

    XCTAssertEqual(widget.requestedSize, RequestedSize(Point(1,4), moldable:Point(1,2)))
  }

  func testGetAllocatedSpaceWithADirectionOfUp() {
    widget.style=Style(
      widgetType <- [
        layoutProperty <- StackLayout(),
        primaryLayoutDirectionProperty <- .up,
      ],

      (widgetType / widgetType) <- [
         layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )

    XCTAssertEqual(child1.allocatedSpace, AllocatedSpace(Point(0,2), Point(1,2)))
    XCTAssertEqual(child2.allocatedSpace, AllocatedSpace(Point(0,0), Point(1,2)))
  }

  func testGetRequestedSizeWithADirectionOfDown() {
    widget.style=Style(
      widgetType <- [
        layoutProperty <- StackLayout(),
        primaryLayoutDirectionProperty <- .down,
      ],

      (widgetType / widgetType) <- [
         layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )

    XCTAssertEqual(widget.requestedSize, RequestedSize(Point(1,4), moldable:Point(1,2)))
  }

  func testGetAllocatedSpaceWithADirectionOfDown() {
    widget.style=Style(
      widgetType <- [
        layoutProperty <- StackLayout(),
        primaryLayoutDirectionProperty <- .down,
      ],

      (widgetType / widgetType) <- [
         layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )

    XCTAssertEqual(child1.allocatedSpace, AllocatedSpace(Point(0,0), Point(1,2)))
    XCTAssertEqual(child2.allocatedSpace, AllocatedSpace(Point(0,2), Point(1,2)))
  }
}

