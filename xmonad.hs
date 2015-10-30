import XMonad
import XMonad.Layout.Maximize
import XMonad.Layout.Minimize
import XMonad.Util.EZConfig

import XMonad.Layout.ToggleLayouts
import qualified XMonad.StackSet as W

main = xmonad $ defaultConfig
       {
         layoutHook = myLayout
       , modMask = myModKey
       } `additionalKeys` myKeys


myTerminal = "xfce4-terminal"
myModKey = mod4Mask
myKeys = [ ((myModKey,			xK_m		), withFocused minimizeWindow)
         , ((myModKey .|. shiftMask, 	xK_m		), sendMessage RestoreNextMinimizedWin)
         , ((myModKey,			xK_y		), withFocused (sendMessage . maximizeRestore))
         , ((myModKey,			xK_q		), kill)
         , ((myModKey,			xK_Return	), spawn myTerminal)
         , ((myModKey .|. shiftMask,	xK_Return	), windows W.swapMaster)
         , ((myModKey .|. shiftMask,	xK_n		), refresh)
         , ((myModKey, 			xK_n		), windows W.focusMaster)
         , ((myModKey .|. shiftMask,	xK_c		), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH; \"$PATH\"; fi")
         , ((myModKey,                  xK_f            ), sendMessage ToggleLayout)
         , ((myModKey,                  xK_p            ), spawn "j4-dmenu-desktop")
         , ((myModKey .|. shiftMask,    xK_p            ), spawn "dmenu_run")

         ]

myLayout = maximize $ minimize $ toggleLayouts Full (tiled ||| Mirror tiled ||| Full)
  where
    tiled = Tall 1 (3/100) (1/2)
