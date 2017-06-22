import Foundation
import AbstractionAsserter
import Properties

public protocol Layout {
  /**
    Gets RequestedSize of widget.
    This is called automaticly when getting Widget.requestedSize.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to get the RequestedSize for.
    - Returns: The RequestedSize for the widget.
  */
  func getRequestedSize(_ widget:Widget) -> RequestedSize

  /**
    Allocate space for contained widget.
    This is called automaticly when getting Widget.allocateSpace.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to allocate space for.
    - Returns: The AllocatedSpace for the widget.
  */
  func allocateSpace(_ widget:Widget) -> AllocatedSpace
}

public let layoutProperty=Property<Layout,Style>(StackLayout())

public let primaryLayoutDirectionProperty=Property<Direction,Style>(.right)
public let secondaryLayoutDirectionProperty=Property<Direction,Style>(.up)

