import AbstractionAsserter
import Properties

private let leadingSideProperty = Property<Int32, Widget>(0)
private let leadingMoldableProperty = Property<Int32, Widget>(0)
private let trailingSideProperty = Property<Int32, Widget>(0)
private let trailingMoldableProperty = Property<Int32, Widget>(0)

public class StackLayout: Layout {
  /**
    Gets RequestedSize of widget.
    This is called automaticly when getting Widget.requestedSize.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to get the RequestedSize for.
    - Returns: The RequestedSize for the widget.
  */
  public func getRequestedSize(_ widget:Widget) -> RequestedSize {
    let isHorizontal = widget.get(property:primaryLayoutDirectionProperty).isHorizontal

    var runningTotalLeadingSize:Int32 = 0
    var runningTotalLeadingMoldable:Int32 = 0
    var runningTotalWidthSize:Int32 = 0
    var runningTotalWidthMoldable:Int32 = 0

    for child in widget.contents {
      let childRequestedSize = isHorizontal ?
        child.requestedSize.pivot() :
        child.requestedSize

      child.set(property:trailingSideProperty, to: runningTotalLeadingSize)
      child.set(property:trailingMoldableProperty, to: runningTotalLeadingMoldable)

      runningTotalLeadingSize += childRequestedSize.size.y
      runningTotalLeadingMoldable += childRequestedSize.moldable.y
      runningTotalWidthSize += childRequestedSize.size.x * childRequestedSize.moldable.x * childRequestedSize.size.y
      runningTotalWidthMoldable += childRequestedSize.moldable.x * childRequestedSize.size.y

      child.set(property:leadingSideProperty, to: runningTotalLeadingSize)
      child.set(property:leadingMoldableProperty, to: runningTotalLeadingMoldable)
    }

    let requestedSize = RequestedSize (
      Point(
        runningTotalWidthSize / runningTotalWidthMoldable,
        runningTotalLeadingSize
      ),
      moldable: Point (
        runningTotalWidthMoldable / runningTotalLeadingSize,
        runningTotalLeadingMoldable
      )
    )

    return isHorizontal ? requestedSize.pivot() : requestedSize
  }

  /**
    Allocate space for contained widget.
    This is called automaticly when getting Widget.allocateSpace.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to allocate space for.
    - Returns: The AllocatedSpace for the widget.
  */
  public func allocateSpace(_ widget:Widget) -> AllocatedSpace {
    guard let container=widget.container else {
      /* TODO Swift warn */
      return AllocatedSpace(
        Point(0,0),
        widget.requestedSize.size
      )
    }
    let isHorizontal = container.get(property:primaryLayoutDirectionProperty).isHorizontal
    let isBackwards = container.get(property:primaryLayoutDirectionProperty).isBackwards

    let containerAllocatedSpace = isHorizontal ?
      container.allocatedSpace.pivot() :
      container.allocatedSpace
      
    let containerRequestedSize = isHorizontal ?
      container.requestedSize.pivot() :
      container.requestedSize

    let remainder = containerAllocatedSpace.size.y - containerRequestedSize.size.y
    let totalMoldable = containerRequestedSize.moldable.y

    let leadingSide = widget.get(property:leadingSideProperty)
    let leadingMoldable = widget.get(property:leadingMoldableProperty)
    let leading = leadingSide + remainder * leadingMoldable / totalMoldable

    let trailingSide = widget.get(property:trailingSideProperty)
    let trailingMoldable = widget.get(property:trailingMoldableProperty)
    let trailing = trailingSide + remainder * trailingMoldable / totalMoldable

    let leadingPosition = isBackwards ? containerAllocatedSpace.size.y - leading : trailing
    let height = leading - trailing
    let width = containerAllocatedSpace.size.x

    let allocatedSpace = AllocatedSpace(Point(0, leadingPosition), Point(width, height))
    return isHorizontal ?
      allocatedSpace.pivot() :
      allocatedSpace
  }

  public init() {
  }
}
