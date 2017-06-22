public struct RequestedSize {
  var size:Point
  var moldable:Point

  /**
    Creates a new RequestedSize.
    - Paramiter size: The requested size for x and y.
    - Parameter moldable: The willingness widget has to accept a different size.
  */
  public init(_ size:Point, moldable:Point=Point(1,1)) {
    self.size=size
    self.moldable=moldable
  }

  func pivot() -> RequestedSize {
    return RequestedSize(size.pivot(), moldable:moldable.pivot())
  }
}

extension RequestedSize:Equatable {

  public static func ==(lhs: RequestedSize, rhs: RequestedSize) -> Bool {
      return lhs.size == rhs.size && lhs.moldable == rhs.moldable
  }
}

