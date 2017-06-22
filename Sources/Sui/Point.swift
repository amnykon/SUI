public struct Point {
  public var x:Int32
  public var y:Int32

  /**
    Create a new Point.
    - Parameter x: The x value.
    - Parameter y: The y value.
  */
  public init (_ x:Int32, _ y:Int32) {
    self.x=x
    self.y=y
  }

  public func pivot() -> Point {
    return Point(y,x)
  }
}

extension Point:Equatable {
  public static func ==(lhs: Point, rhs: Point) -> Bool {
      return lhs.x == rhs.x && lhs.y == rhs.y
  }
}

extension Point /* :IntegerArithmetic */ {
  public static func +(lhs: Point, rhs: Point) -> Point {
    return Point(lhs.x+rhs.x, lhs.y+rhs.y)
  }

  public static func -(lhs: Point, rhs: Point) -> Point {
    return Point(lhs.x-rhs.x, lhs.y-rhs.y)
  }

  public static func /(lhs: Point, rhs: Int32) -> Point {
    return Point(lhs.x/rhs, lhs.y/rhs)
  }

  public static func /(lhs: Point, rhs: Point) -> Point {
    return Point(lhs.x/rhs.x, lhs.y/rhs.y)
  }

  public static func *(lhs: Point, rhs: Int32) -> Point {
    return Point(lhs.x*rhs, lhs.y*rhs)
  }

  public static func *(lhs: Point, rhs: Point) -> Point {
    return Point(lhs.x*rhs.x, lhs.y*rhs.y)
  }
}

/**
  create a new Point with the max value for each dimension.
  - Returns: a new point with the max value for each dimension.
*/
public func max(_ a:Point,_ b:Point) -> Point {
  return Point(max(a.x,b.x), max(a.y,b.y))
}

/**
  create a new Point with the min value for each dimension.
  - Returns: a new point with the min value for each dimension.
*/
public func min(_ a:Point,_ b:Point) -> Point {
  return Point(min(a.x,b.x), min(a.y,b.y))
}

