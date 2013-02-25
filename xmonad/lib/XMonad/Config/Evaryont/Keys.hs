module XMonad.Config.Evaryont.Keys (
      key_bindings,
      toggleStrutsKey
      ) where

import Music.Pandora
import System.Environment
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Config.Evaryont.Logout
import XMonad.Config.Evaryont.Settings
import XMonad.Config.Evaryont.Utils
import XMonad.Darcs.Util.EZConfig
import XMonad.Darcs.Util.NamedActions
import XMonad.Util.WorkspaceScreenshot
import qualified XMonad.StackSet as W

import XMonad.Actions.WithAll (killAll)
import XMonad.Actions.CopyWindow (kill1)
import System.Exit

-- Key bindings. Add, modify or remove key bindings here.
--
--key_bindings = 
--   [
--    ("M-d a", addName "useless message" $ spawn "xmessage foo"),
--    ("M-c", sendMessage' Expand)]
--   , ("M-<Escape>",    addName "Close the current window"             $ kill)
--   , ("M-S-<Escape>",  addName "Close target window"                  $ spawn "xkill")
--   , ("M-q",           addName "Lock the screen"                      $ spawn lockScreen)
--   , ("M-S-q",         addName "Restart XMonad"                       $ restart "xmonad" True)
--   , ("M-C-q",         addName "Magic KDE dialog"                     $ logoutDialog)
--   , ("M-S-p",         addName "Take a screenshot (gnome-panel)"      $ spawn "gnome-panel-screenshot -i")
--   , ("M-t",           addName "Toggle current window's float status" $ toggleFloat)
--   , ("M-?",           addName "Show the configured keys"             $ spawn "show-xmonad-keys")
--   , ("M-S-?",         addName "Show the configured keys"             $ spawn "show-xmonad-keys")
--   ]


key_bindings c =
       key_killing c
    ++ key_apps c
    ++ key_windows c
    ++ key_workspace c
    ++ key_music c
    ++ key_misc c

key_killing conf =
    (subtitle "Killing & Restarting":) $ mkNamedKeymap conf $
    [ ("M-<Escape>", addName "Kill current window" $ kill1)
    , ("M-S-c", addName "Kill current window (alternative bind)" $ kill1)
    , ("M-S-<Escape>", addName "Kill all windows on workspace" $ killAll)
    , ("M-C-<Escape>", addName "Restart XMonad" $ spawn "xmonad --recompile && xmonad --restart")
    , ("M-S-C-<Escape>", addName "Quit XMonad" $ io (exitWith ExitSuccess))
    ]

key_apps conf =
    (subtitle "Application launching":) $ mkNamedKeymap conf $
    [ ("M-<Return>", addName "Launch terminal" $ spawn terminal_choice)
    , ("M-p", addName "Run dmenu to launch an application" $ spawn "~/bin/dmenu-run")
    , ("M-x", addName "Switch to another window" $ spawn "xwinmosaic")
    ]

key_windows conf = 
    (subtitle "Focus changing":) $ mkNamedKeymap conf $
    [ ("M-j", addName "Focus next"     $ windows W.focusDown)
    , ("M-k", addName "Focus previous" $ windows W.focusUp  )
    ]

key_workspace conf =
    (subtitle "Workspace movement":) $ mkNamedKeymap conf $
    [ ("M-l",           addName "Go to next non-empty workspace"       $ moveTo Next NonEmptyWS)
    , ("M-h",           addName "Go to previous non-empty workspace"   $ moveTo Prev NonEmptyWS)
    , ("M-S-l",         addName "Go to next empty workspace"           $ moveTo Next EmptyWS)
    , ("M-S-h",         addName "Go to previous empty workspace"       $ moveTo Prev EmptyWS)
    , ("M-<Backspace>", addName "Toggle the last workspace you're on"  $ toggleWS)
    ]

key_music conf =
    (subtitle "Music control":) $ mkNamedKeymap conf $
    [ ("M-a",           addName "Music control (pandora only)"         $ pandoraSelect)
    , ("<XF86AudioPlay>", addName "Toggle MPD" $ spawn "mpc toggle")
    , ("<XF86AudioNext>", addName "Next song in the playlist" $ spawn "mpc next")
    ]

key_misc conf =
    (subtitle "Uncategorized":) $ mkNamedKeymap conf $
    [ ("M-e",           addName "Go to next Xinerama screen"     $ nextScreen)
    , ("M-<Print>",     addName "Screenshot every workspace"     $ captureWorkspacesWhen defaultPredicate captureHook horizontally)
    , ("M-t",           addName "Toggle floating current window" $ toggleFloat)
    ]

--subtitle' :: String -> (String, NamedAction)
--subtitle' str = ([], NamedAction $ str ++ ":")

toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- vim: set nospell:
