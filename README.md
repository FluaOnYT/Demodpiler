# Demodpiler

A script that extracts contents of ModuleScripts all in a string format

## Q&A

### How does it work?

It extracts in 3 steps:

1. "Require" (I.e., import) a ModuleScript
2. Iterate through the contents of the ModuleScript
3. Parse every keys' value into a string and combines them into a pseduocode of the ModuleScript

### What is the current % of type support?

```42.5%``` (Including unsupported ones)

```63.0%``` (Excluding unsupported ones that are non-extractable)

### What are the unsupported types?

These types include ones unextractable by any means (no properties that can be reversed to arguments for a constructor for such types), types that do not have a constructor and types that are not used in game (i.e., studio only types)

```
Region3
RBXScriptSignal
RBXScriptConnection
RaycastResult
Random
NumberSequence
Faces
Enums
EnumItem
Enum
DockWidgetPluginGuiInfo
DateTime
Content
Axes
```

One or two of these may be supported after initial release
