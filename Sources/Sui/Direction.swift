import Foundation

public enum Direction {
  case up
  case down
  case left
  case right

  var isVertical:Bool {
    switch self {
      case .up, .down:
        return true
      case .left, .right:
        return false
    }
  }

  var isHorizontal:Bool {
    return !isVertical
  }

  var isBackwards:Bool {
    switch self {
      case .up, .left:
        return true
      case .down, .right:
        return false
    }
  }
}
