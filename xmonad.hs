import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Grid
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO

myManageHook = composeAll
		[ title =? "plugin-container"             --> doFullFloat
		--, className =? "MPlayer"                  --> doShift "5:video"
		, className =? "Steam"                    --> doShift "9:games"
                , className =? "Team Fortress 2 - OpenGL" --> doShift "9:games"
		]

myLayoutHook = onWorkspace "5:vid" fullL $ onWorkspace "9:games" fullL $ standardLayouts	
  where
    standardLayouts = avoidStruts (tiled ||| Mirror tiled ||| Grid ||| Full ) ||| Full
    -- Note the bracketing - means there are two fulls. One that respects the
    -- dock and one that doesn't.

    -- Layouts
    tiled           = smartBorders (ResizableTall 1 (2/100) (1/2) [])
    reflectTiled    = reflectHoriz tiled
    full            = smartBorders Full
    -- Fullscreen:
    fullL        	= noBorders Full

 
main = do
  spawn "trayer --edge top --align right --expand false --width 9 --transparent true --alpha 0 --tint 0x000000 --height 16"
  spawn "gtk-redshift"

  xmproc <- spawnPipe "/usr/local/bin/xmobar /home/cody/.xmonad/xmobarrc"
  xmonad $  ewmh defaultConfig {
               modMask = mod4Mask,
               terminal = "urxvt",
               manageHook = myManageHook <+> manageDocks,
               layoutHook = myLayoutHook,
               logHook = dynamicLogWithPP $ xmobarPP
                         { ppOutput = hPutStrLn xmproc
                         , ppTitle = xmobarColor "skyblue" "" . shorten 50
                         }
             }
             `additionalKeysP`
             [ ("M-S-h", sendMessage ToggleStruts) 
             , ("M-S-z", spawn "slock")
             , ("M-s", spawn "import /home/cody/screenshots/$(date +'%s').png")
             , ("M-S-s", spawn "import -window ROOT /home/cody/screenshots/$(date +'%s')-fullscreen.png")
             , ("M-q", spawn "killall trayer; killall gtk-redshift; xmonad --recompile; xmonad --restart")
             ]
