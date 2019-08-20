//
//  ViewController.swift
//  JTool
//
//  Created by Jingting Chen on 2019/8/18.
//  Copyright © 2019 Jingting. All rights reserved.
//

import UIKit

public class RootViewController : UIViewController {

  private let titleLabel = UILabel(frame: .zero)

  public override func viewDidLoad()
  {
    super.viewDidLoad()

    view.backgroundColor = .white

    titleLabel.text = "测试"
    titleLabel.textColor = .black
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(titleLabel)

    [
      titleLabel.centerXAnchor ==~ view.centerXAnchor,
      titleLabel.centerYAnchor ==~ view.centerYAnchor,
    ].activate()
  }


}

