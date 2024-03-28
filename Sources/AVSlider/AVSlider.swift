import UIKit

open class AVSlider: UIControl, UIGestureRecognizerDelegate {

    private var backgroundView: UIView!
    private var progressView: UIView!
    private var _progress: Double = 0.5
    private var initialGestureOffset: CGFloat = 0
    private var isExpanded: Bool = false {
        didSet { updateUI(for: isExpanded) }
    }
    public var valueLabel: UILabel?
    private var showValueLabel: Bool
    private var valueLabelPosition: ValueLabelPosition = .top
    
    
    public var trackingMode: TrackingMode = .offset
    public var expansionMode: ExpansionMode = .onTouch

    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 330, height: 12)
    }

    public var progress: Double {
        get {
            return _progress
        } set {
            _progress = newValue
        }
    }

    open override var tintColor: UIColor! {
        get {
            return progressView.backgroundColor
        } set {
            progressView.backgroundColor = newValue
        }
    }

    open override var backgroundColor: UIColor? {
        get {
            return backgroundView.backgroundColor
        } set {
            backgroundView.backgroundColor = newValue
        }
    }

    public init(frame: CGRect, showValueLabel: Bool? = false) {
        self.showValueLabel = showValueLabel ?? false
        super.init(frame: frame)
        setupBackgroundView()
        setupProgressView()
        setupValueLabel()
        setupGestureRecognizers()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBackgroundView() {
        backgroundView = UIView()
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 3.5
        if #available(iOS 13.0, *) {
            backgroundView.layer.cornerCurve = .continuous
            backgroundView.backgroundColor = .tertiarySystemFill
        } else {
            backgroundView.layer.cornerRadius = 3.5
            backgroundView.backgroundColor = UIColor.gray
        }
        addSubview(backgroundView)
    }

    private func setupProgressView() {
        progressView = UIView()
        progressView.alpha = 0.5
        progressView.backgroundColor = tintColor
        backgroundView.addSubview(progressView)
    }

    private func setupValueLabel() {
        if showValueLabel {
            valueLabel = UILabel()
            valueLabel?.font = UIFont.systemFont(ofSize: 12)
            valueLabel?.textColor = .black
            valueLabel?.textAlignment = .left
            addSubview(valueLabel!)
        }
    }

    private func setupGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer.delegate = self
        panGestureRecognizer.addTarget(self, action: #selector(panGestureRecognized))

        let longPressGestureRecognizer = UILongPressGestureRecognizer()
        longPressGestureRecognizer.delegate = self
        longPressGestureRecognizer.minimumPressDuration = 0
        longPressGestureRecognizer.addTarget(self, action: #selector(longPressGestureRecognized))

        addGestureRecognizer(panGestureRecognizer)
        addGestureRecognizer(longPressGestureRecognizer)
    }

    @objc private func panGestureRecognized(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let location = sender.location(in: self).x
            initialGestureOffset = location - progressView.frame.maxX
        case .possible, .changed:
            setIsExpanded(true, animated: true)
        default:
            setIsExpanded(false, animated: true)
        }

        let location = sender.location(in: self).x
        let offset = trackingMode == .offset ? initialGestureOffset : 0
        let width = location - offset
        progressView.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)

        _progress = min(max(width / frame.width, 0), 1)
        sendActions(for: .valueChanged)

        sendActions(for: .editingDidEnd)
    }

    @objc private func longPressGestureRecognized(_ sender: UITapGestureRecognizer) {
        if expansionMode == .onTouch {
            switch sender.state {
            case .began:
                setIsExpanded(true, animated: true)
            case .ended:
                setIsExpanded(false, animated: true)
            default:
                return
            }
        }
    }

    private func updateUI(for isExpanded: Bool) {
        progressView.alpha = isExpanded ? 1 : 0.5
        layoutBackgroundView()
    }

    private func layoutBackgroundView() {
        let x: CGFloat = 0
        let width = frame.width
        let height: CGFloat = isExpanded ? 12 : 7
        let y = (frame.height / 2) - (height / 2)
        backgroundView.frame = CGRect(x: x, y: y, width: width, height: height)
        backgroundView.layer.cornerRadius = height / 2

        if let valueLabel = valueLabel {
            switch valueLabelPosition {
            case .top:
                valueLabel.frame = CGRect(x: 5, y: -frame.height, width: 50, height: frame.height)
            case .bottom:
                valueLabel.frame = CGRect(x: 5, y: frame.height, width: 50, height: frame.height)
            }
        }
    }

    private func layoutProgressViewIfNeeded() {
        if progressView.frame.height != frame.height {
            let width = (frame.width * progress) - initialGestureOffset
            let height = backgroundView.frame.height
            progressView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }
    }

    private func setIsExpanded(_ isExpanded: Bool, animated: Bool) {
        let duration = animated ? 0.15 : 0

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
            self.isExpanded = isExpanded
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutBackgroundView()
        layoutProgressViewIfNeeded()
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    public func setValueLabelPosition(_ position: ValueLabelPosition) {
        self.valueLabelPosition = position
        setNeedsLayout()
    }
}

public extension AVSlider {
    enum TrackingMode {
        case offset
        case absolute
    }
}

public extension AVSlider {
    enum ExpansionMode {
        case onTouch
        case onDrag
    }
}

public extension AVSlider {
    enum ValueLabelPosition {
        case top
        case bottom
    }
}
