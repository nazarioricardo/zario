Audiobus SDK -- Version 3.0.0 -- May 17th 2017
==============================================

Thanks for downloading the Audiobus distribution!

See https://developer.audiob.us/doc/ for the developer documentation,
and see the Samples folder for a number of sample projects.

If you have any questions, please don't hesitate to join us on 
the developer community forum at https://heroes.audiob.us.

Cheers!

Audiobus Team
https://audiob.us

Changes
=======


3.0.0
-----

Important:

 - For developers already using the Audiobus 2 SDK, please read the [2.0 to 3.0 Migration Guide]( https://developer.audiob.us/doc/_migration-_guide.html)
 - Audiobus compatible apps now need to link `libz.tbd`

Features:

 - MIDI support!
     - The Audiobus SDK now supports the creation of MIDI Sender, MIDI Filter and MIDI Receiver ports.
     - See the AB Sender sample app (included within SDK distribution) to see MIDI Receiver ports and MIDI Sender ports in action.
     - See AB MIDI Filter sample app to see MIDI Filter ports in action.
 - Reworked Audio Unit Management to facilitate robust background launching.
 - Connection Panel shows Audio Unit Extensions like ordinary apps, and allows
   switching to Audio Unit Extension instances: Tapping an Audio Unit Extension
   launch button opens Audiobus and reveals the corresponding instance.
 - Improved API Key validator. Many errors are detected and reported in the console.
 - Introduced various `ABPort` properties to retrieve information about sources,
   assigned pipelines, etc.

Fixes:

 - Apps that offer Inter-App Audio instrument ports are treated as MIDI receiver ports.
 - Fixes issues with `ABAudioReceiverPort` in Audiobus 3
 - Fixes sporadic crash in `ABAudioReceiverPort` when changing client format
 - Fixed SDK crash when using interleaved stereo format

2.3.2
-----

 - Fixed Connection Panel positioning problems in split screen mode.
 - Fixed potential crashes with privately used ABLogger
 - Added UIControlEventTouchCancel to list of supported control events for
   trigger buttons
 - Moved NSNetService and NSNetServiceBrowser discovery/monitoring to a secondary
   thread. This should fix situations where connection trigger state
   updates were delayed for multiple seconds.
 - Added code that will help to terminate zombie processes in future.
 - Added a workaround in ABAudioFilterPort for iOS bug that results in a buffer size mismatch,
   causing crashes in apps using a filter port with a process block (rather than an audio unit),
   when used on a device with a hardware sample rate different to the app sample rate, such as the
   iPhone 6S Plus.
 - Update sample rate of hosted IAA nodes when setting clientFormat property of ABAudioReceiverPort. This
   avoids some unnecessary sample rate conversion in certain circumstances.
 - Sometimes output apps do not show the right icons.
 - If your app shows names and icons of other apps, please do the following:
 - Replace calls of "port.peer.name" by "port.pipelineTitle".
 - Replace calls of "port.peer.icon" by "port.pipelineIcon".
 - Observe property port.pipelineTitle and port.pipelineIcon. If it changes update you UI.
 - All of this new requirements are implemented in the sample app "AB Multitrack".


2.3.1
-----

 - Improvements to synchronization and latency management

2.3
---

 - Added Ableton Link support
 - Support for displaying the Connection Panel in apps that use split screen mode
 - Sample rate indepedence and fixes for iPhone 6s
 - Bitcode support enabled

2.2.2
-----

 - Important: Please visit http://developer.audiob.us and register a new version
   of your app, making sure to set the SDK version to 2.2.2 or above.
   You will then get a new, valid API key.
 - Additionally make sure there that the ports defined in your info.plist
   AudioComponents matching the ports registered at http://developer.audiob.us.
   If that is not the case you are required to match both and generate a
   new API Key. This is required to alow a proper identification of installed
   apps on iOS9.
 - Addressed issues with icon resources and AB Remote.
 - Fixed crash associated with expired API key.


2.2.1
-----

 - Important changes to app switching: A new iOS 9 security measure prompts for confirmation with 
   every new app switch. We now switch via Audiobus, to limit the number of prompts.
 - Improved updating of changed app icons within AB Remote

2.2
---

 - Added addRemoteTrigger: method to ABAudiobusController. This method
   allows you to define triggers that are only shown in the new Audiobus Remote app.
 - Added addRemoteTriggerMatrix:rows:cols: to ABAudiobusController. This method makes
   it possible to define a matrix of trigger buttons which are shown in
   Audiobus Remote.
 - Added addBlock:forRemoteControlEvents: method to ABButtonTrigger. This
   method allows you to let your app react to touch down and touch up events
   originating within Audiobus Remote.
 - Addressed iOS 9 problems with Connection Panel
 - Added new ABConnectionPanelPositionTop Connection Panel position.
 - Fixed problems with using kAudioUnitType_RemoteMusicEffect audio component type.
 - Added registerAdditionalAudioComponentDescription: utility to ABAudioFilterPort.

2.1.6.1
-------

 - Fixed a crash in certain circumstances while using multi-channel audio interfaces

2.1.6
-----

 - Added public init methods for triggers, to allow subclassing
 - Added registerAdditionalAudioComponentDescription: method to ABAudioSenderPort,
   allowing use of secondary AudioComponentDescriptions with the same port.
 - Tweaked connection panel hide/show; don't re-show after user has hidden
 - Fixed some issues with ABAudioUnitFader
 - Removed ABAnimatedTrigger from SDK (contact us if you're using this)
 - Addressed issue with view rotation while connection panel hidden
 - Don't mute filter port when there's no input
 - Various other fixes

2.1.5
-----

 - Added ABAudioUnitFader class, for smooth fade-in/fade-out transitions instead of hard
   clicks when starting or stopping your audio system.
 - Fixed crash on ABAudiobusController dealloc
 - Fixed an issue with the connection panel being blank when changing position soon after
   launch.
 - Added workaround for connection panel 'stripe' on rotation on iOS 8
 - Fixed a sporadic issue with chaining filters
 - Fixed an issue with missing app icons in connection panel prior to launch
 - Added code to handle an iOS Bonjour bug resulting in address resolution failure
 - Fixed sample rate conversion issue

2.1.4
-----

 - Added 'audiobusConnected' and 'interAppAudioConnected' properties to local port classes
 - Added 'interAppAudioConnected' property to ABAudiobusController
 - Added 'memberOfActiveAudiobusSession' property to ABAudiobusController which replaces
   'audiobusAppRunning' property in determining whether an app should remain active in the
   background.
 - Fixed an issue with ABAudioSenderPort when created with user audio unit and connected to self
 - Adjusted buffering in ABAudioSenderPortSend to allow for non-hardware buffer duration
   enqueue lengths
 - Improvements to internal buffering mechanisms
 - Addressed issue when setting a sender or filter port's audioUnit property to NULL
 - Addressed a Bonjour namespace collision issue
 - Adjusted 'connected' state change notification behaviour
 - Tweaked IAA shutdown

2.1.3
-----

 - Fixed connection panel position issues on iOS 8 when built with Xcode 6
 - Fixed issues resuming after audio session interruption
 - Fixed an occasional crash when run from debugger
 - Added support for reporting IAA hosting issues via Audiobus UI
 - Added checking for String-typed "version" AudioComponents field
 - Revised handling for disconnection in sample code
 - Avoid a possible crash when recreating network socket

2.1.2
-----

 - Widen draggable surface area for connection panel drag-in tab
 - Revised muting policy for apps with multiple sender ports
 - Fixed an issue with filters muting when a new, un-launched source is added

2.1.1
-----

 - Fixed an assertion problem during state restoring ("must have completionBlock")
 - Fixed an audio conversion issue with ABAudioReceiverPort with receiveMixedAudio = NO
 - Added some extra Info.plist sanity checks

2.1
---

Major new update, with Inter-App Audio integration, state saving, a new connection panel
design and an easier, cleaner, simpler API.

Check out our [migration guide](https://developer.audiob.us/migrate) for details.
