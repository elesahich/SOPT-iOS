//
//  PokeNotificationListContentView.swift
//  PokeFeature
//
//  Created by Ian on 12/3/23.
//  Copyright © 2023 SOPT-iOS. All rights reserved.
//

import Core
import DSKit

import UIKit

final public class PokeNotificationListContentView: UIView {
    private enum Metrics {
        static let contentDefaultSpacing = 8.f
        static let leftToCenterContentPadding = 12.f
        
        static let centerToRightContentPadding = 8.f
        static let centerTopContentPadding = 8.f
        
        static let centerSeperateContentsMinHeight = 22.f

        static let centerContentPaddingAfterDescription = 4.f
    }
    
    private enum Constant {
        static let numberOfLinesForDetailView = 2
        static let defaultNumberOfLines = 1
    }
    
    // MARK: - ContentStack
    private lazy var contentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = Metrics.contentDefaultSpacing
        $0.alignment = .center
    }
    
    // MARK: Left:
    // To be replaced
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 25.f
        $0.image = UIImage(asset: DSKitAsset.Assets.imgNotificationNon)
        $0.layer.borderWidth = 2.f
        $0.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.4).cgColor
    }
    
    // MARK: Center:
    private lazy var centerContentsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
    }
    private lazy var centerTopContentsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = Metrics.centerTopContentPadding
        $0.alignment = .center
    }
    
    // Center-Top
    private let nameLabel = UILabel().then {
        $0.font = DSKitFontFamily.Suit.medium.font(size: 14)
        $0.textColor = DSKitAsset.Colors.gray30.color
        $0.textAlignment = .left
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    private let partInfoLabel = UILabel().then {
        $0.font = DSKitFontFamily.Suit.semiBold.font(size: 11)
        $0.textColor = DSKitAsset.Colors.gray300.color
        $0.textAlignment = .left
    }
    
    // Center-middle
    private lazy var descriptionLabel = UILabel().then {
        $0.numberOfLines = self.isDetailView ? Constant.numberOfLinesForDetailView : Constant.defaultNumberOfLines
    }
    
    // Center-bottom
    private lazy var pokeChipView = PokeChipView(frame: self.frame)
    
    // MARK: Right:
    // To be replaced
    private let rightButton = UIImageView().then {
        $0.layer.cornerRadius = 18.f
        $0.image = UIImage(asset: DSKitAsset.Assets.icnYoutube)?.withRenderingMode(.alwaysTemplate)
    }
    
    private let isDetailView: Bool
    
    // MARK: - View Lifecycle
    public init(
        isDetailView: Bool = true,
        frame: CGRect
    ) {
        self.isDetailView = isDetailView
        super.init(frame: frame)

        self.initializeViews()
        self.setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokeNotificationListContentView {
    private func initializeViews() {
        self.addSubview(self.contentStackView)
        
        self.contentStackView.addArrangedSubviews(
            self.profileImageView,
            self.centerContentsStackView,
            self.rightButton
        )
        
        self.centerContentsStackView.addArrangedSubviews(
            self.centerTopContentsStackView,
            self.descriptionLabel,
            self.pokeChipView
        )
        
        self.centerTopContentsStackView.addArrangedSubviews(
            self.nameLabel,
            self.partInfoLabel
        )
        
        self.contentStackView.setCustomSpacing(
            Metrics.leftToCenterContentPadding,
            after: self.centerContentsStackView
        )
        
        self.centerContentsStackView.setCustomSpacing(
            Metrics.centerContentPaddingAfterDescription,
            after: self.descriptionLabel
        )
    }
    
    private func setupConstraint() {
        self.contentStackView.snp.makeConstraints { $0.directionalEdges.equalToSuperview() }

        self.centerTopContentsStackView.snp.makeConstraints { $0.height.equalTo(Metrics.centerSeperateContentsMinHeight) }
        self.descriptionLabel.snp.makeConstraints { $0.height.greaterThanOrEqualTo(Metrics.centerSeperateContentsMinHeight) }
        self.profileImageView.snp.makeConstraints { $0.size.equalTo(50.f) }
        self.rightButton.snp.makeConstraints { $0.size.equalTo(50.f) }
    }
}

extension PokeNotificationListContentView {
    public func configure(with model: NotificationListContentModel) {
        if let url = URL(string: model.avatarUrl) {
            self.profileImageView.kf.setImage(with: url)
        }
        
        self.nameLabel.text = model.name
        self.partInfoLabel.text = model.partInfomation
        self.descriptionLabel.attributedText = model.description.applyMDSFont()
        self.pokeChipView.configure(with: model.chipInfo)
        self.rightButton.tintColor = model.isPoked ? .systemGray : .systemBrown
    }
    
    public func poked() {
        // TBD
    }
}

// NOTE(@승호): MDSFont 적용하고 DSKit으로 옮기고 적용하기.
private extension String {
  func applyMDSFont() -> NSMutableAttributedString {
    self.applyMDSFont(
      height: 22.f,
      font: DSKitFontFamily.Suit.medium.font(size: 14),
      color: DSKitAsset.Colors.gray30.color,
      letterSpacing: 0.f
    )
  }
  
  func applyMDSFont(
    height: CGFloat,
    font: UIFont,
    color: UIColor,
    letterSpacing: CGFloat,
    alignment: NSTextAlignment = .left,
    lineBreakMode: NSLineBreakMode = .byTruncatingTail
  ) -> NSMutableAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = lineBreakMode
    paragraphStyle.minimumLineHeight = height
    paragraphStyle.alignment = alignment
    
    if lineBreakMode == .byWordWrapping {
      paragraphStyle.lineBreakStrategy = .hangulWordPriority
    }
    
    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: color,
      .font: font,
      .kern: letterSpacing,
      .paragraphStyle: paragraphStyle,
      .baselineOffset: (paragraphStyle.minimumLineHeight - font.lineHeight) / 4
    ]
    
    let attrText = NSMutableAttributedString(string: self)
    attrText.addAttributes(attributes, range: NSRange(location: 0, length: self.utf16.count))
    return attrText
  }
}
