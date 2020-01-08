import XMonad
import XMonad.Config.Kde
import XMonad.Util.EZConfig
import XMonad.Layout.Spacing
import XMonad.Actions.CycleWS
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.BinarySpacePartition


main = 
    xmonad $
    ewmh $ 
    myConfig

myConfig = kdeConfig
    { modMask = mod4Mask -- Windows key as mod
    , handleEventHook = handleEventHook kdeConfig <+> fullscreenEventHook
    , manageHook = manageHook kdeConfig <+> myManageHook
    , layoutHook = myLayoutHook
    , normalBorderColor = "#000000"
    , focusedBorderColor = "#000000"
    , terminal = "alacritty"
    } `additionalKeysP` myKeymaps

myManageHook = composeAll . concat $ 
    [ [className =? c --> doFloat | c <- classesToFloat]
    ]
    where classesToFloat = ["plasmashell", "Plasma", "krunner", "Kmix", "Klipper", "Plasmoidviewer"]

myKeymaps = 
    [ ("M-d", spawn "rofi -show drun")
    , ("M-<R>", nextWS)
    , ("M-<L>", prevWS)
    , ("M-S-<R>", shiftToNext)
    , ("M-S-<L>", shiftToPrev)
    ]

myLayoutHook =
    desktopLayoutModifiers $
    noBorders $
    spacingRaw True (Border 5 5 5 5) True (Border 5 5 5 5) True $
    layoutHook kdeConfig ||| emptyBSP
