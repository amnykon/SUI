import XCTest
@testable import Sui
import Properties

class LayoutPropertyTests: XCTestCase {
  func testDefaultIsStackLayout() {
    let widgetType=WidgetType(parent:anyWidgetType)
    let widget=Widget(type:widgetType)
    XCTAssertEqual(String(describing:type(of:widget.get(property:layoutProperty))), String(describing:StackLayout.self))
  }
}
