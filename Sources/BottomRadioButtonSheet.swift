//
//  BottomRadioButtonSheet.swift
//
//  Created by Siarhei Lukyanau on 18.11.25.
//
import UIKit

public struct BottomRadioButtonSheetConfiguration {
    public var title: String?
    public var rowHeight: CGFloat = 56
    public var bottomMargin: CGFloat = 24
    public var showUniqueIcon: Bool = true
    public var radioButtonSelected: UIImage?
    public var radioButtonDeselected: UIImage?
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
    public var optionFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    public var titleToOptionsSpacing: CGFloat = 12

    public init(title: String? = nil,
                rowHeight: CGFloat = 56,
                bottomMargin: CGFloat = 24,
                showUniqueIcon: Bool = true,
                radioButtonSelected: UIImage? = nil,
                radioButtonDeselected: UIImage? = nil,
                titleFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .semibold),
                optionFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular),
                titleToOptionsSpacing: CGFloat = 12) {
        self.title = title
        self.rowHeight = rowHeight
        self.bottomMargin = bottomMargin
        self.showUniqueIcon = showUniqueIcon
        self.radioButtonSelected = radioButtonSelected
        self.radioButtonDeselected = radioButtonDeselected
        self.titleFont = titleFont
        self.optionFont = optionFont
        self.titleToOptionsSpacing = titleToOptionsSpacing
    }
}

public class BottomRadioButtonSheet: UIViewController {

    private let options: [String]
    private let icons: [String]?
    private var selectedIndex: Int
    private let configuration: BottomRadioButtonSheetConfiguration
    private var completion: ((Int) -> Void)?

    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()

    private let topHandle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 3
        return view
    }()

    private let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
        return view
    }()

    private var titleLabel: UILabel?
    private var hasAnimatedIn = false
    private var isDismissing = false

    public init(options: [String],
                icons: [String]? = nil,
                selectedIndex: Int = 0,
                configuration: BottomRadioButtonSheetConfiguration = BottomRadioButtonSheetConfiguration(),
                completion: ((Int) -> Void)? = nil) {
        self.options = options
        self.icons = icons
        self.selectedIndex = selectedIndex
        self.configuration = configuration
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupUI()
        setupConstraints()
        setupMenuRows()
        setupPanGesture()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasAnimatedIn {
            contentView.transform = CGAffineTransform(translationX: 0, y: contentView.bounds.height)
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !hasAnimatedIn else { return }
        hasAnimatedIn = true

        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.bounds.height)
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.5,
            options: [.curveEaseOut]
        ) {
            self.dimmingView.alpha = 1
            self.contentView.transform = .identity
        }
    }

    private func setupUI() {
        view.addSubview(dimmingView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        dimmingView.addGestureRecognizer(tapGesture)

        contentView.addSubview(topHandle)
        view.addSubview(contentView)

        if let title = configuration.title {
            let label = UILabel()
            label.text = title
            label.font = configuration.titleFont
            label.textAlignment = .center
            label.numberOfLines = 0
            contentView.addSubview(label)
            titleLabel = label
        }
    }

    private func setupConstraints() {
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        topHandle.translatesAutoresizingMaskIntoConstraints = false

        let titleHeight: CGFloat = configuration.title != nil
            ? ceil(configuration.titleFont.lineHeight) + 8
            : 0
        let headerHeight: CGFloat = 24 + titleHeight + configuration.titleToOptionsSpacing
        let rowsHeight = configuration.rowHeight * CGFloat(options.count)
        let separatorsHeight = CGFloat(max(options.count - 1, 0))
        let totalHeight = headerHeight + rowsHeight + separatorsHeight + configuration.bottomMargin

        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: totalHeight),

            topHandle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            topHandle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topHandle.widthAnchor.constraint(equalToConstant: 40),
            topHandle.heightAnchor.constraint(equalToConstant: 6)
        ])

        if let titleLabel {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
                titleLabel.heightAnchor.constraint(equalToConstant: titleHeight)
            ])
        }
    }

    private func setupMenuRows() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0

        let titleHeight: CGFloat = configuration.title != nil
            ? ceil(configuration.titleFont.lineHeight) + 8
            : 0
        let startY: CGFloat = configuration.title != nil
            ? 24 + titleHeight + configuration.titleToOptionsSpacing
            : 48

        for (index, option) in options.enumerated() {
            let row = createMenuRow(
                text: option,
                icon: icons?[index],
                isSelected: index == selectedIndex,
                index: index
            )
            stackView.addArrangedSubview(row)

            if index < options.count - 1 {
                stackView.addArrangedSubview(createSeparator())
            }
        }

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: startY),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -configuration.bottomMargin)
        ])
    }

    private func createMenuRow(text: String, icon: String?, isSelected: Bool, index: Int) -> UIView {
        let rowView = UIView()
        rowView.backgroundColor = .clear

        let radioIcon = UIImageView()
        radioIcon.translatesAutoresizingMaskIntoConstraints = false
        radioIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        radioIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true

        if let selectedImage = configuration.radioButtonSelected,
           let deselectedImage = configuration.radioButtonDeselected {
            radioIcon.image = isSelected ? selectedImage : deselectedImage
        } else {
            let systemImageName = isSelected ? "largecircle.fill.circle" : "circle"
            radioIcon.image = UIImage(systemName: systemImageName)
        }
        radioIcon.tintColor = isSelected ? .systemBlue : .systemGray

        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.font = configuration.optionFont
        label.numberOfLines = 1

        var arrangedSubviews: [UIView] = [radioIcon, label]

        if configuration.showUniqueIcon, let iconName = icon {
            let uniqueIcon = UIImageView()
            uniqueIcon.image = UIImage(systemName: iconName)
            uniqueIcon.tintColor = .systemGray
            uniqueIcon.translatesAutoresizingMaskIntoConstraints = false
            uniqueIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
            uniqueIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
            arrangedSubviews.append(uniqueIcon)
        }

        let innerStackView = UIStackView(arrangedSubviews: arrangedSubviews)
        innerStackView.axis = .horizontal
        innerStackView.spacing = 12
        innerStackView.alignment = .center

        rowView.addSubview(innerStackView)
        innerStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            innerStackView.leadingAnchor.constraint(equalTo: rowView.leadingAnchor, constant: 24),
            innerStackView.trailingAnchor.constraint(lessThanOrEqualTo: rowView.trailingAnchor, constant: -24),
            innerStackView.centerYAnchor.constraint(equalTo: rowView.centerYAnchor)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(rowTapped(_:)))
        rowView.addGestureRecognizer(tapGesture)
        rowView.tag = index

        rowView.heightAnchor.constraint(equalToConstant: configuration.rowHeight).isActive = true

        return rowView
    }

    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .systemGray5
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }

    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        contentView.addGestureRecognizer(panGesture)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: contentView)

        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                contentView.transform = CGAffineTransform(translationX: 0, y: translation.y)
                dimmingView.alpha = max(0, 1 - (translation.y / 300))
            }
        case .ended:
            if translation.y > 100 {
                dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.transform = .identity
                    self.dimmingView.alpha = 1
                }
            }
        default:
            break
        }
    }

    @objc private func rowTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        selectedIndex = index
        completion?(index)
        dismiss(animated: true)
    }

    @objc private func handleBackgroundTap() {
        dismiss(animated: true)
    }

    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        guard !isDismissing else { return }
        isDismissing = true

        UIView.animate(withDuration: 0.25, animations: {
            self.dimmingView.alpha = 0
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.bounds.height)
        }) { _ in
            super.dismiss(animated: false, completion: completion)
        }
    }
}
