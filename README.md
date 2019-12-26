# NGUIViewLayerBackgroundColorTest
Example app which demonstrates that layers which back views do not have implicit animations by default.

The app has two layers - one backed by a view, one not. Two toggles control the background colors of the layers - you can see that one animates by default while the other does not. There's another toggle that controls whether the view returns a CAAction from it's layer delegate method - toggling this on causes the view's backing layer to animate.
