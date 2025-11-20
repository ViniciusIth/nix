import Quickshell
import "../config"
import "./components"

BarButton {
    color: Colourscheme.subtle
    colorHover: Colourscheme.love
    icon: "power_off.svg"
    onClicked: {
        Quickshell.execDetached(["niri", "msg", "action", "quit"]);
    }
}
