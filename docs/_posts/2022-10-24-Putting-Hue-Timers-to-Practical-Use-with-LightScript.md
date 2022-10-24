---

title: Putting Hue Timers to Practical Use with LightScript
author: StartAutomating
sourceURL: https://github.com/StartAutomating/LightScript/issues/44
---
I've just put something into the oven and put my smart lighting to work for me.

I ran this little script to make my lights blink when the oven is done:

~~~PowerShell
Import-Module LightScript
Add-HueSchedule -In '00:11:00' -Command (Set-HueLight -OutputInput -Alert lselect) -Name blink11
~~~

And in 11 minutes, my lights will all flash for 10 seconds.

All of my home fixtures use Phillips Hue lights, and Hue was the first ecosystem LightScript supported.

Hue lights can flash.  You've probably noticed this when you hit a light's icon in the Hue App.

What's less obvious is that you can flash them for a _long_ time.

The normal flash is called an 'alert' by the api, and it's called 'select'.  That lasts about two seconds.

You can also alert with lselect.  That lasts about 10.

Let's break down what we're doing:

`Add-HueSchedule` is the command that sets up a schedule in hue.  Schedules can be at specific times, intervals, or `-In [Timespan]` (in this case `-In '00:11:00'`) .  Schedules need a name, so we give it one: blink11.

The way the Hue Bridge works with schedules it that when the schedule is triggered it will send a message to another resource on the bridge.   That's where `Set-HueLight` comes in.

Without specifying a -Light or -Room, `Set-HueLight` will default to setting all hue lights.  `-Alert lselect` is what we're telling the lights to do (blink for 10 seconds).  Next, we pass -OutputInput because we don't want to do this, we want this to happen when we're scheduled to run.

Try it.

Trust me. 

You'll notice when the oven is done. 

Happy LightScripting!
