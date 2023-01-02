//
//  SentenceEditVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/12/22.
//  Copyright © 2022 SOPT-Stamp-iOS. All rights reserved.
//

import UIKit

import Core
import DSKit

import Combine
import SnapKit
import Then

public class SentenceEditVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: SentenceEditViewModel!
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .titleWithLeftButton)
        .setTitle(I18N.Setting.SentenceEdit.sentenceEdit)
        .setTitleTypoStyle(.h1)
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = DSKitAsset.Colors.white.color
        tv.textColor = DSKitAsset.Colors.gray900.color
        tv.setTypoStyle(.subtitle1)
        tv.layer.cornerRadius = 9.adjustedH
        tv.layer.borderWidth = 1.adjustedH
        tv.layer.borderColor = DSKitAsset.Colors.purple300.color.cgColor
        tv.isEditable = true
        tv.textContainerInset = UIEdgeInsets(top: 13, left: 16, bottom: 13, right: 16)
        tv.delegate = self
        return tv
    }()
    
    private let saveButton = CustomButton(title: I18N.Setting.SentenceEdit.save)
        .setEnabled(false)
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
        self.setUI()
        self.setLayout()
    }
}

// MARK: - Methods

extension SentenceEditVC {
    
    private func bindViewModels() {
        let textViewTextChanged = NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self.textView)
            .dropFirst()
            .map { ($0.object as? UITextView)?.text }
            .compactMap { $0 }
            .eraseToAnyPublisher()
            .asDriver()
        
        let saveButtonTapped = self.saveButton
            .publisher(for: .touchUpInside)
            .compactMap { _ in self.textView.text }
            .filter { !$0.isEmpty }
            .asDriver()
        
        let input = SentenceEditViewModel.Input(textChanged: textViewTextChanged,
                                                saveButtonTapped: saveButtonTapped)
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
        
        output.$saveButtonEnabled
            .assign(to: self.saveButton.kf.isEnabled, on: self.saveButton)
            .store(in: self.cancelBag)
        
        output.$defaultText
            .assign(to: self.textView.kf.text, on: self.textView)
            .store(in: self.cancelBag)
        
        output.editSuccessed
            .withUnretained(self)
            .sink { owner, isSuccessed in
                if isSuccessed {
                    owner.navigationController?.popViewController(animated: true)
                } else {
                    owner.showNetworkAlert()
                }
            }.store(in: self.cancelBag)
    }
    
    public func showNetworkAlert() {
        let alertVC = AlertVC(alertType: .networkErr)
            .setTitle(I18N.Default.networkError, I18N.Default.networkErrorDescription)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }
}

// MARK: - UI & Layout

extension SentenceEditVC {
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setLayout() {
        self.view.addSubviews(naviBar, textView, saveButton)
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(8.adjustedH)
            make.leading.trailing.equalToSuperview().inset(20.adjusted)
            make.height.equalTo(64.adjustedH)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(32.adjustedH)
            make.leading.trailing.equalToSuperview().inset(20.adjusted)
            make.height.equalTo(56.adjustedH)
        }
    }
}

// MARK: - TextViewDelegate

extension SentenceEditVC: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        return newLength <= 42
    }
}
