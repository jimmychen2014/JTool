//
//  NSLayoutAnchor+LayoutAnchorDSL.swift
//  JTool
//
//  Created by Jingting Chen on 2019/8/20.
//  Copyright © 2019 Jingting. All rights reserved.
//

import UIKit

public enum TLayoutAnchorExpression<AnchorType: AnyObject> {
  case additive(anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat)
}

@_transparent // https://github.com/apple/swift/blob/master/docs/TransparentAttr.rst
public func + <AnchorType: AnyObject> (anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> TLayoutAnchorExpression<AnchorType>
{
  return .additive(anchor: anchor, constant: constant)
}

@_transparent
public func - <AnchorType: AnyObject> (anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> TLayoutAnchorExpression<AnchorType>
{
  return .additive(anchor: anchor, constant: -constant)
}

public enum TLayoutDimensionExpression {
  case multiplicative(anchor: NSLayoutDimension, multiplier: CGFloat)
  case additiveMultiplicative(anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat)
}

@_transparent
public func * (anchor: NSLayoutDimension, multiplier: CGFloat) -> TLayoutDimensionExpression
{
  return .multiplicative(anchor: anchor, multiplier: multiplier)
}

@_transparent
public func / (anchor: NSLayoutDimension, divider: CGFloat) -> TLayoutDimensionExpression
{
  return .multiplicative(anchor: anchor, multiplier: 1.0 / divider)
}

@_transparent
public func + (expression: TLayoutDimensionExpression, constant: CGFloat) -> TLayoutDimensionExpression
{
  switch expression {
  case let .multiplicative(anchor: anchor, multiplier: multiplier):
    return .additiveMultiplicative(anchor: anchor, multiplier: multiplier, constant: constant)

  case let .additiveMultiplicative(anchor: anchor, multiplier: multiplier, constant: existingConstant):
    return .additiveMultiplicative(anchor: anchor, multiplier: multiplier, constant: existingConstant + constant)
  }
}

@_transparent
public func - (expression: TLayoutDimensionExpression, constant: CGFloat) -> TLayoutDimensionExpression
{
  switch expression {
  case let .multiplicative(anchor: anchor, multiplier: multiplier):
    return .additiveMultiplicative(anchor: anchor, multiplier: multiplier, constant: -constant)

  case let .additiveMultiplicative(anchor: anchor, multiplier: multiplier, constant: existingConstant):
    return .additiveMultiplicative(anchor: anchor, multiplier: multiplier, constant: existingConstant - constant)
  }
}

infix operator ==~ : ComparisonPrecedence
infix operator >=~ : ComparisonPrecedence
infix operator <=~ : ComparisonPrecedence

@_transparent
public func ==~ <AnchorType: AnyObject> (lhs: NSLayoutAnchor<AnchorType>, rhs: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint
{
  return lhs.constraint(equalTo: rhs)
}

@_transparent
public func >=~ <AnchorType: AnyObject> (lhs: NSLayoutAnchor<AnchorType>, rhs: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint
{
  return lhs.constraint(greaterThanOrEqualTo: rhs)
}

@_transparent
public func <=~ <AnchorType: AnyObject> (lhs: NSLayoutAnchor<AnchorType>, rhs: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint
{
  return lhs.constraint(lessThanOrEqualTo: rhs)
}

@_transparent
public func ==~ <AnchorType: AnyObject> (lhs: NSLayoutAnchor<AnchorType>, rhs: TLayoutAnchorExpression<AnchorType>) -> NSLayoutConstraint
{
  switch rhs {
  case let .additive(anchor: anchor, constant: constant):
    return lhs.constraint(equalTo: anchor, constant: constant)
  }
}

@_transparent
public func >=~ <AnchorType: AnyObject> (lhs: NSLayoutAnchor<AnchorType>, rhs: TLayoutAnchorExpression<AnchorType>) -> NSLayoutConstraint
{
  switch rhs {
  case let .additive(anchor: anchor, constant: constant):
    return lhs.constraint(greaterThanOrEqualTo: anchor, constant: constant)
  }
}

@_transparent
public func <=~ <AnchorType: AnyObject> (lhs: NSLayoutAnchor<AnchorType>, rhs: TLayoutAnchorExpression<AnchorType>) -> NSLayoutConstraint
{
  switch rhs {
  case let .additive(anchor: anchor, constant: constant):
    return lhs.constraint(lessThanOrEqualTo: anchor, constant: constant)
  }
}

@_transparent
public func ==~ (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint
{
  return lhs.constraint(equalToConstant: rhs)
}

@_transparent
public func >=~ (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint
{
  return lhs.constraint(greaterThanOrEqualToConstant: rhs)
}

@_transparent
public func <=~ (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint
{
  return lhs.constraint(lessThanOrEqualToConstant: rhs)
}

@_transparent
public func ==~ (lhs: NSLayoutDimension, rhs: TLayoutDimensionExpression) -> NSLayoutConstraint
{
  switch rhs {
  case let .multiplicative(anchor: anchor, multiplier: multiplier):
    return lhs.constraint(equalTo: anchor, multiplier: multiplier)

  case let .additiveMultiplicative(anchor: anchor, multiplier: multiplier, constant: constant):
    return lhs.constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
  }
}

@_transparent
public func >=~ (lhs: NSLayoutDimension, rhs: TLayoutDimensionExpression) -> NSLayoutConstraint
{
  switch rhs {
  case let .multiplicative(anchor: anchor, multiplier: multiplier):
    return lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier)

  case let .additiveMultiplicative(anchor: anchor, multiplier: multiplier, constant: constant):
    return lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
  }
}

@_transparent
public func <=~ (lhs: NSLayoutDimension, rhs: TLayoutDimensionExpression) -> NSLayoutConstraint
{
  switch rhs {
  case let .multiplicative(anchor: anchor, multiplier: multiplier):
    return lhs.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier)

  case let .additiveMultiplicative(anchor: anchor, multiplier: multiplier, constant: constant):
    return lhs.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
  }
}

infix operator !~ : LogicalConjunctionPrecedence

@_transparent
public func !~ (lhs: NSLayoutConstraint, rhs: UILayoutPriority) -> NSLayoutConstraint
{
  lhs.priority = rhs
  return lhs
}


