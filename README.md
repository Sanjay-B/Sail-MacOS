# Sail-MacOS
Our core Mac App for the Sail Community Project

## Development 

Unlike most chat applications, Sail is created for Mac. With many applications today using technologies such as C# and JS, we plan to use as much Swift (a native language to MacOS) to create our app. This means there will be better addaption of newer technology, less bugs, and better flow of the app.

## Roadmap

Please see your development lead for your goals beyond what is listed. These are not yet publicly available.

[ X ] Create the base application
[ ] Create a base UI per the modual map
[ ] Integrate the Sail SDK

### NOTICE && Notes

App Sandbox and Hardened Runtime are enabled. If this becomes a problem during development, please see a team leader to have them get approval from a project leader to disable one or both features. You MUST show where in the code this is causing failure, what you have done to attempt to resolve this without disabling these features, as well as why the feature is crucial to the app and cannot just be removed.

- When adding things near the top bar of the application (Main.storyboard), remember the top bar is intergrated into the desing of the application. This means you need to adjust your constraints around this design element.
- Logout code is LOCAL based on a secessful logout call. DO NOT assume logout is always successful. This is not a flaw, this is just current design and will likely change in the future.
