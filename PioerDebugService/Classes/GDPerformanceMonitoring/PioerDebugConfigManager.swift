

import Foundation
import CocoaDebug

@objcMembers
open class PioerDebugConfigManager: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        inLDebugConfig()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 初始化 Debug 配置
    @objc func inLDebugConfig() {
        CocoaDebugSettings.shared.firstIn = ""
//        if CConfigBaseDefaults.showDebugWindow == true {
            PerformanceMonitor.shared().start()
            showLDebugWindow(show: true)
//        } else {
//            showLDebugWindow(show: false)
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            CocoaDebugSettings.shared.responseShake = false
        }
    }
    public func showLDebugWindow(show: Bool) {
        if show {
            #if DEBUG
            findLeakOverView()?.isHidden = false
            PerformanceMonitor.shared().start()
            PerformanceMonitor.shared().show()
            CocoaDebug.showBubble()
            #endif
        } else {
            if findLeakOverView() != nil {
                findLeakOverView()?.isHidden = true
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                    findLeakOverView()?.isHidden = true
                }
            }
            PerformanceMonitor.shared().pause()
            PerformanceMonitor.shared().hide()
            CocoaDebug.hideBubble()
        }
//        CConfigBaseDefaults.showDebugWindow = show

        func findLeakOverView() -> UIView? {
            var leakOverview: UIView?
            if let window = UIApplication.shared.keyWindow {
                for subview in window.subviews {
                    if let leakViewClass = NSClassFromString("AMLeakOverviewView"),
                       subview.isKind(of: leakViewClass) {
                        leakOverview = subview
                        break
                    }
                }
            }
            return leakOverview
        }
    }
}
