import XMonad
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The default number of workspaces (virtual screens) and their names.
--
the_workspaces    = ["1","2","3","4","5","6","7","8","9"]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
key_bindings = \c -> mkKeymap c $
             [ ("M-<Escape>", kill)
             , ("M-<Space>", sendMessage NextLayout)
             , ("M-r", refresh)
             , ("M-j", windows W.focusDown)
             , ("M-k", windows W.focusUp)
             , ("M-x", goToSelected gsConfig)
             -- MPC keyboard control
             , ("<XF86AudioPlay>", spawn "exec mpc toggle")
             , ("<XF86AudioStop>", spawn "exec mpc stop")
             , ("<XF86AudioPrev>", spawn "exec mpc prev")
             , ("<XF86AudioNext>", spawn "exec mpc next")
             -- My keyboard (a G15) also includes volume controls, but KDE already
             -- manages some of them.
             -- For reference, the keys are <XF86AudioMute> <XF86AudioRaiseVolume> <XF86AudioLowerVolume>

             -- TODO: This will be replaced by a bashrun (but using zsh!) clone
             , ("M-g", appendFilePrompt defaultXPConfig "/home/colin/notes/notes.txt")

             -- mpc control via 'normal' keys
             , ("M-a", submap . M.fromList $
                 [ ((0, xK_l),     spawn "mpc next")
                 , ((0, xK_h),     spawn "mpc prev")
                 , ((0, xK_z),     spawn "mpc random")
                 , ((0, xK_space), spawn "mpc toggle")
                 ])

             -- Spawn the configured terminal
             , ("M-<Return>", spawn $ XMonad.terminal conf)
             ]

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
manage_hook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Startup hook
--
-- Check the keymap for duplicates, errors, etc
--
startup_hook = return () >> checkKeymap the_settings key_bindings

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
--
main = xmonad the_settings

-- A structure containing the configuration settings.
-- Any you don't override, will use the defaults defined in
-- xmonad/XMonad/Config.hs
--
the_settings = defaultConfig {
        terminal           = "urxvt.sh",
        modMask            = mod4mask,
        workspaces         = the_workspaces,
        keys               = key_bindings,
        manageHook         = manage_hook,
        startupHook        = startup_hook
    }

--- vim: set syn=haskell nospell: